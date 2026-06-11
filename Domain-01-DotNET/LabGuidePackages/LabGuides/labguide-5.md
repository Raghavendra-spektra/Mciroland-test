# **Scenario 5: Secure Login Using ASP.NET Core Identity**

## **Lab Overview**

In this lab, you will implement comprehensive user authentication and management using ASP.NET Core Identity, including password hashing, user registration, secure login, and account management.

## **Scenario**

Your organization requires a complete user management system with secure password handling, account lockout policies, and email verification. You need to implement registration, login, password reset, and account management features.

## **Learning Objectives**

After completing this lab, you will be able to:

* Configure ASP.NET Core Identity
* Implement user registration with validation
* Implement secure login with password verification
* Configure password policies and lockout rules
* Send email notifications
* Implement password reset functionality

---

## **Implementation Steps**

### Step 1: Install Required Packages

```powershell
dotnet add package Microsoft.AspNetCore.Identity
dotnet add package Microsoft.AspNetCore.Identity.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package SendGrid
```

---

### Step 2: Create Identity Models

**Models/IdentityUser.cs**

```csharp
using Microsoft.AspNetCore.Identity;

namespace ProductAPI.Models
{
    public class AppUser : IdentityUser
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsActive { get; set; }
    }
}
```

---

### Step 3: Update DbContext

```csharp
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using ProductAPI.Models;

namespace ProductAPI.Data
{
    public class ProductContext : IdentityDbContext<AppUser>
    {
        public ProductContext(DbContextOptions<ProductContext> options) 
            : base(options)
        {
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<ProductImage> ProductImages { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Product>().HasKey(p => p.Id);
            modelBuilder.Entity<Product>()
                .Property(p => p.Name)
                .IsRequired()
                .HasMaxLength(100);

            modelBuilder.Entity<AppUser>()
                .Property(u => u.FirstName)
                .HasMaxLength(50);

            modelBuilder.Entity<AppUser>()
                .Property(u => u.LastName)
                .HasMaxLength(50);
        }
    }
}
```

---

### Step 4: Create Registration DTO

**DTOs/RegisterRequest.cs**

```csharp
namespace ProductAPI.DTOs
{
    public class RegisterRequest
    {
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
```

---

### Step 5: Create Identity Service

**Services/IIdentityService.cs**

```csharp
using ProductAPI.DTOs;
using ProductAPI.Models;

namespace ProductAPI.Services
{
    public interface IIdentityService
    {
        Task<(bool success, string message)> RegisterAsync(RegisterRequest request);
        Task<LoginResponse> LoginAsync(LoginRequest request);
        Task<bool> ConfirmEmailAsync(string userId, string token);
        Task<bool> ResetPasswordAsync(string email, string token, string newPassword);
        Task SendPasswordResetEmailAsync(string email, string resetToken);
    }
}
```

**Services/IdentityService.cs**

```csharp
using Microsoft.AspNetCore.Identity;
using ProductAPI.Data;
using ProductAPI.DTOs;
using ProductAPI.Models;
using ProductAPI.Services;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Text;

namespace ProductAPI.Services
{
    public class IdentityService : IIdentityService
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IConfiguration _configuration;
        private readonly ILogger<IdentityService> _logger;

        public IdentityService(
            UserManager<AppUser> userManager,
            SignInManager<AppUser> signInManager,
            IConfiguration configuration,
            ILogger<IdentityService> logger)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _configuration = configuration;
            _logger = logger;
        }

        public async Task<(bool success, string message)> RegisterAsync(RegisterRequest request)
        {
            try
            {
                if (request.Password != request.ConfirmPassword)
                    return (false, "Passwords do not match");

                var user = new AppUser
                {
                    UserName = request.Username,
                    Email = request.Email,
                    FirstName = request.FirstName,
                    LastName = request.LastName,
                    CreatedDate = DateTime.UtcNow,
                    IsActive = true
                };

                var result = await _userManager.CreateAsync(user, request.Password);

                if (!result.Succeeded)
                {
                    var errors = string.Join(", ", result.Errors.Select(e => e.Description));
                    _logger.LogWarning("User registration failed for {Email}: {Errors}", request.Email, errors);
                    return (false, errors);
                }

                _logger.LogInformation("User registered successfully: {Email}", request.Email);
                return (true, "User registered successfully");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error registering user: {Email}", request.Email);
                return (false, "An error occurred during registration");
            }
        }

        public async Task<LoginResponse> LoginAsync(LoginRequest request)
        {
            try
            {
                var user = await _userManager.FindByNameAsync(request.Username);

                if (user == null)
                {
                    _logger.LogWarning("Login failed: User not found {Username}", request.Username);
                    return null;
                }

                var result = await _signInManager.PasswordSignInAsync(
                    user, request.Password, isPersistent: false, lockoutOnFailure: true);

                if (!result.Succeeded)
                {
                    _logger.LogWarning("Login failed for user {Username}", request.Username);
                    return null;
                }

                var token = GenerateJwtToken(user);
                _logger.LogInformation("User logged in successfully: {Username}", request.Username);

                return new LoginResponse { Token = token, Username = user.UserName };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error during login for user {Username}", request.Username);
                return null;
            }
        }

        public async Task<bool> ConfirmEmailAsync(string userId, string token)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
                return false;

            var result = await _userManager.ConfirmEmailAsync(user, token);
            return result.Succeeded;
        }

        public async Task<bool> ResetPasswordAsync(string email, string token, string newPassword)
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
                return false;

            var result = await _userManager.ResetPasswordAsync(user, token, newPassword);
            return result.Succeeded;
        }

        public async Task SendPasswordResetEmailAsync(string email, string resetToken)
        {
            // This would integrate with SendGrid or another email service
            await Task.CompletedTask;
        }

        private string GenerateJwtToken(AppUser user)
        {
            var jwtSecret = _configuration["Jwt:Secret"];
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSecret));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id),
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim("FirstName", user.FirstName),
                new Claim("LastName", user.LastName)
            };

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddHours(1),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
```

---

### Step 6: Update Program.cs

```csharp
builder.Services.AddIdentity<AppUser, IdentityRole>(options =>
{
    options.Password.RequiredLength = 8;
    options.Password.RequireDigit = true;
    options.Password.RequireNonAlphanumeric = true;
    options.Password.RequireUppercase = true;
    options.Lockout.MaxFailedAccessAttempts = 5;
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(15);
})
.AddEntityFrameworkStores<ProductContext>()
.AddDefaultTokenProviders();

builder.Services.AddScoped<IIdentityService, IdentityService>();
```

---

### Step 7: Create Identity Controller

**Controllers/AccountController.cs**

```csharp
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ProductAPI.DTOs;
using ProductAPI.Services;

namespace ProductAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AccountController : ControllerBase
    {
        private readonly IIdentityService _identityService;

        public AccountController(IIdentityService identityService)
        {
            _identityService = identityService;
        }

        [HttpPost("register")]
        public async Task<ActionResult> Register(RegisterRequest request)
        {
            var (success, message) = await _identityService.RegisterAsync(request);
            if (!success)
                return BadRequest(message);

            return Ok(new { message = "User registered successfully" });
        }

        [HttpPost("login")]
        public async Task<ActionResult<LoginResponse>> Login(LoginRequest request)
        {
            var result = await _identityService.LoginAsync(request);
            if (result == null)
                return Unauthorized("Invalid credentials");

            return Ok(result);
        }

        [Authorize]
        [HttpGet("profile")]
        public async Task<ActionResult> GetProfile()
        {
            return Ok(new { message = "User authenticated successfully" });
        }
    }
}
```

---

### Step 8: Test User Registration and Login

**Register:**
```
POST https://localhost:5001/api/account/register
Content-Type: application/json

{
  "email": "user@example.com",
  "username": "user123",
  "password": "SecurePass123!",
  "confirmPassword": "SecurePass123!",
  "firstName": "John",
  "lastName": "Doe"
}
```

**Login:**
```
POST https://localhost:5001/api/account/login
Content-Type: application/json

{
  "username": "user123",
  "password": "SecurePass123!"
}
```

---

## **Validation Check**

Validation will verify:

* ASP.NET Core Identity is configured
* User registration works correctly
* Password policies are enforced
* Login with JWT token works
* Account lockout policies function

---

After completing the task, click the **Validation** tab.

<validation step="e5f6g7h8-i9j0-k1l2-m3n4-o5p6q7r8s9t0" />

---

You have successfully completed all .NET scenarios!
