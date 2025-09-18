<h1 align="center">TIC-TAC-TOE-GAME</h1>


<h2>Commands to create S3 and Dynamo DB</h2>

```bash
aws s3api create-bucket --bucket terraforms3backend2025 --region us-east-1     #replace with your bucket name

aws dynamodb create-table \
  --table-name terraform-lock-table \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST 
  ```
