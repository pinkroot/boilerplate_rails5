## ABOUT
Rails5系のボイラープレートです。
Heroku上で動作させる前提で構築しています。

### 主なライブラリ・設定
- postgres
- active admin

## USAGE
config/master.key
を配備後、下記コマンドにて環境の立ち上げが可能です。  
ホストPCのソースファイル等がDockerコンテナ内に同期され、データベースはDockerコンテナ上で動きつつもデータの永続化がされます。

サーバは
http://localhost:3008
に立ち上がっています。

### コマンド
#### 初回起動・環境の再構築
```
make bundle
make dbinit
make up
```

#### 2回目以降の起動
```
make up
```

#### Gemfile変更時
```
make bundle
```

#### migration時
```
make migrate
```

### 仕組み
Makefile内での定義を経由してdocker-composeコマンドを発火させています。  
各コマンドの詳細が知りたい場合はMakefileを御覧ください。

## 開発環境でのメール確認
letter_opener_webを導入しているため、RAILS_ENV=development環境下では

http://localhost:3008/letter_opener

にて送信メールの確認が可能です。  
SendGrid等を経由してのメール送信は行われません。
