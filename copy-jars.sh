cp mall-admin/target/*.jar ./jars
cp mall-common/target/*.jar ./jars
cp mall-demo/target/*.jar ./jars
cp mall-mbg/target/*.jar ./jars
cp mall-portal/target/*.jar ./jars
cp mall-search/target/*.jar ./jars
cp mall-security/target/*.jar ./jars

To delete S3 files that are 1 week old using awscli, you can use the following command:

```
aws s3 ls s3://your-bucket-name/ --recursive | grep 'PREFIX/.*' | awk '{print $4}' | while read line; do if [ $(aws s3 ls s3://your-bucket-name/"$line" | awk '{print $1}') \< $(date -d '1 week ago' +%s) ]; then aws s3 rm s3://your-bucket-name/"$line"; fi; done
```

Make sure to replace "your-bucket-name" with the name of your S3 bucket, and "PREFIX" with the prefix of the files you want to delete. You can also adjust the time range by changing the "1 week ago" argument to a different time range.

Note: This command will permanently delete the files, so make sure you have a backup if necessary.

