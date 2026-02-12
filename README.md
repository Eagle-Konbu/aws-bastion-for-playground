# AWS Bastion for Playground

SSM Session Manager を使って、AWS 上のプライベートリソース（RDS、ALB など）へポートフォワーディングするための EC2 踏み台サーバ。

- SSH 不要（キーペアなし、インバウンドポートゼロ）
- SSM Agent 経由で接続（Amazon Linux 2023 にプリインストール済み）
- t3.nano で月額約 $8（停止中はほぼ無料）

## 前提条件

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.10
- [Task](https://taskfile.dev/installation/) (go-task)
- AWS CLI v2
- [Session Manager Plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)

```bash
brew install terraform go-task session-manager-plugin
```

## AWS ログイン

セッションが切れた場合は、以下でログインし直す。

```bash
aws login --profile <PROFILE_NAME>
```

## デプロイ

```bash
# 初回のみ（S3 バケットが未作成の場合は自動作成される）
task init AWS_PROFILE=<PROFILE_NAME>

# 変更内容の確認
task plan AWS_PROFILE=<PROFILE_NAME>

# 適用
task apply AWS_PROFILE=<PROFILE_NAME>

# 削除
task destroy AWS_PROFILE=<PROFILE_NAME>
```

## ポートフォワーディング

デプロイ後、`bastion_instance_id` を使って SSM 経由でポートフォワーディングする。

### RDS (PostgreSQL) の例

```bash
aws ssm start-session \
  --target <INSTANCE_ID> \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["your-rds.xxx.ap-northeast-1.rds.amazonaws.com"],"portNumber":["5432"],"localPortNumber":["15432"]}' \
  --profile <PROFILE_NAME>
```

ローカルから接続:

```bash
psql -h 127.0.0.1 -p 15432 -U myuser -d mydb
```

### ALB (HTTPS) の例

```bash
aws ssm start-session \
  --target <INSTANCE_ID> \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["internal-my-alb-xxx.ap-northeast-1.elb.amazonaws.com"],"portNumber":["443"],"localPortNumber":["18443"]}' \
  --profile <PROFILE_NAME>
```

### Instance ID の確認

```bash
task get-instance-id AWS_PROFILE=<PROFILE_NAME>
```
