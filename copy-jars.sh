cp mall-admin/target/*.jar ./jars
cp mall-common/target/*.jar ./jars
cp mall-demo/target/*.jar ./jars
cp mall-mbg/target/*.jar ./jars
cp mall-portal/target/*.jar ./jars
cp mall-search/target/*.jar ./jars
cp mall-security/target/*.jar ./jars
Here is a list of some of the actions that can beHere's an example YAML file that creates a Kubernetes service account named "my-service-account" with full cluster-admin permissions:

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-service-account
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: my-cluster-admin
subjects:
  - kind: ServiceAccount
    name: my-service-account
    namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
```

You can apply this YAML file using the `kubectl apply` command:

```
kubectl apply -f <filename>.yaml
```

Make sure you have the necessary permissions to create service accounts and cluster role bindings in your Kubernetes cluster.


To use a secret for the bind password in the Argo CD Helm chart's `dex.config`, you can follow these steps:

1. Create a Kubernetes Secret that contains the password as a key-value pair. For example, you can create a secret called `dex-bind-secret` with the password `mysecret` like this:

   ```
   kubectl create secret generic dex-bind-secret --from-literal=password=mysecret
   ```

2. In your `values.yaml` file, replace the password string with a reference to the secret. For example, if you have the following values in your `values.yaml` file:

   ```
   dex:
     config:
       ...
       connectors:
         - type: ldap
           ...
           bindDN: "cn=admin,dc=my-domain,dc=com"
           bindPW: "mysecret"
           ...
       ...
   ```

   You can replace the `bindPW` value with a reference to the secret:

   ```
   dex:
     config:
       ...
       connectors:
         - type: ldap
           ...
           bindDN: "cn=admin,dc=my-domain,dc=com"
           bindPWSecret:
             name: dex-bind-secret
             key: password
           ...
       ...
   ```

   This will set the `bindPW` value for the LDAP connector to the contents of the `password` key in the `dex-bind-secret` secret.

3. When you install the Argo CD Helm chart, pass the `--set` flag to specify the LDAP bind password secret name. For example:

   ```
   helm install argocd argo/argocd --set-file dex.config.connectors[0].bindPWSecret=/path/to/dex-bind-secret.yaml
   ```

   This will set the `dex.config.connectors[0].bindPWSecret` value to the contents of the `dex-bind-secret.yaml` file, which should contain the following:

   ```
   apiVersion: v1
   kind: Secret
   metadata:
     name: dex-bind-secret
   type: Opaque
   data:
     password: <base64-encoded password>
   ```

   Note: If you have other values in your `values.yaml` file that depend on the LDAP bind password, you should replace those values with references to the secret as well.
   



To save a.txt to an S3 bucket with a date-time prefix, you can use the `aws` command-line interface (CLI). First, make sure you have the CLI installed and configured with your AWS credentials.

Then, you can use the following command to upload a.txt to S3:

```
aws s3 cp a.txt s3://my-bucket/$(date +"%Y-%m-%d_%H-%M-%S")_a.txt
```

Replace `my-bucket` with the name of your S3 bucket. This will create a new file with a name in the format `YYYY-MM-DD_HH-MM-SS_a.txt` in the root of your bucket.

To save the file daily, you can create a cron job that runs the above command every day at a specific time. For example, to run the command at 3:30 AM every day, you can add the following line to your crontab file (run `crontab -e` to edit it):

```
30 3 * * * aws s3 cp a.txt s3://my-bucket/$(date +"\%Y-\%m-\%d")_a.txt
```

This will create a new file with a name in the format `YYYY-MM-DD_a.txt` in the root of your bucket every day at 3:30 AM.

To keep only the latest 6 history files in your S3 bucket, you can use the following command:

```
aws s3 ls s3://my-bucket/ | grep _a.txt | sort -r | awk 'NR>6{print "s3://my-bucket/" $NF}' | xargs -r aws s3 rm
```

This will list all files in your bucket that match the pattern `*_a.txt`, sort them by modification time (newest first), skip the latest 6 files, and delete the rest. Replace `my-bucket` with the name of your S3 bucket.




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

