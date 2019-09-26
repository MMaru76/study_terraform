# study_terraform

# Terraform 学習

## 学習環境について

- Mac Mojave 10.14.6（18G95）

## インストールから初期設定方法

基本的に利用するまでの最初の設定を記述


### AWS CLI install

```bash
pip3 install awscli --upgrade
```

### AWS CLI setup

```bash
export AWS_ACCESS_KEY_ID=IDをペースト
export AWS_SECRET_ACCESS_KEY=シークレットをペースト
export AWS_DEFAULT_REGION=リージョンを入力
```

> 特に指定が無い場合は､東京リージョン ap-northeast-1

### aws
```
aws sts get-caller-identity --query Account --output text
```

## 対象のディレクトリにて下記コマンドを実行

```
git secrets --install
```

## 初回に限り実行
```
git secrets --register-aws --global
git secrets --install ~/.git-templates/git-secrets
git config --global init.templatedir '~/.git-templates/git-secrets'
```

## 各種コマンド

- リソース作成に必要なバイナリファイルを取得

```bash
terraform init
```

- 実行計画 コマンド

```bash
terraform plan
```

- 実行 コマンド

```bash
terraform apply
```

- 削除 コマンド

```bash
terraform destroy
```

## 各種 説明

### 実行結果 解説

- aws_instance.example will be created
  - 新規にリソースを作成する
- aws_instance.example will be updated in-place
  - 既存のリソースの設定を変更する
- aws_instance.example must be replaced
  - 既存のリソースを削除して新しいリソースを作成する

### 変更履歴
- Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
  - 1個追加(成功)
- Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
  - 1個変更(編集)
- Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
  - 1個作成,1個削除
- Destroy complete! Resources: 1 destroyed.
  - 1個削除
