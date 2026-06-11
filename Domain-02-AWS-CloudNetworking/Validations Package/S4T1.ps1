# S3 Bucket Validation
$region = "us-east-1"

Set-DefaultAWSRegion -Region $region

try {
    $bucket = Get-S3Bucket -BucketName "production-data-bucket*" -ErrorAction Stop
    
    $versioning = Get-S3BucketVersioning -BucketName $bucket.BucketName
    
    if ($versioning.Status -eq "Enabled") {
        echo "PASS"
    } else {
        echo "FAIL"
    }
}
catch {
    echo "FAIL"
}
