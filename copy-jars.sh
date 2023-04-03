cp mall-admin/target/*.jar ./jars
cp mall-common/target/*.jar ./jars
cp mall-demo/target/*.jar ./jars
cp mall-mbg/target/*.jar ./jars
cp mall-portal/target/*.jar ./jars
cp mall-search/target/*.jar ./jars
cp mall-security/target/*.jar ./jars
Here is a list of some of the actions that can be performed on an S3 bucket or object through a policy:

- s3:PutObject: Allows a user to create or upload an object to the bucket.
- s3:GetObject: Allows a user to download an object from the bucket.
- s3:ListBucket: Allows a user to list the objects in a bucket.
- s3:DeleteObject: Allows a user to delete an object from the bucket.
- s3:ListAllMyBuckets: Allows a user to list all the buckets in their account.
- s3:GetBucketLocation: Allows a user to retrieve the location of a bucket.
- s3:GetBucketPolicy: Allows a user to retrieve the policy of a bucket.
- s3:PutBucketPolicy: Allows a user to put a new policy on the bucket.
- s3:DeleteBucketPolicy: Allows a user to delete the policy of a bucket.
- s3:ListBucketVersions: Allows a user to list all the versions of objects in a bucket.
- s3:PutObjectTagging: Allows a user to add or modify tags to an object.
- s3:GetObjectTagging: Allows a user to retrieve the tags of an object.
- s3:DeleteObjectTagging: Allows a user to delete the tags of an object.
- s3:GetBucketEncryption: Allows a user to retrieve the encryption configuration of a bucket.
- s3:PutBucketEncryption: Allows a user to put a new encryption configuration on the bucket.

This is not a comprehensive list, but it covers some of the most common actions that can be performed on an S3 bucket or object through a policy.
To delete S3 files that are 1 week old using awscli, you can use the following command:

```
aws s3 ls s3://your-bucket-name/ --recursive | grep 'PREFIX/.*' | awk '{print $4}' | while read line; do if [ $(aws s3 ls s3://your-bucket-name/"$line" | awk '{print $1}') \< $(date -d '1 week ago' +%s) ]; then aws s3 rm s3://your-bucket-name/"$line"; fi; done
```

Make sure to replace "your-bucket-name" with the name of your S3 bucket, and "PREFIX" with the prefix of the files you want to delete. You can also adjust the time range by changing the "1 week ago" argument to a different time range.

Note: This command will permanently delete the files, so make sure you have a backup if necessary.

