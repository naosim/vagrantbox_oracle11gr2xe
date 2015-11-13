# 概要
Oracle XE入りのVagrantです。

# 使い方

## プロビジョニングまで
1. OracleのサイトからOracleXEの媒体をダウンロードしてshareの下に置いてください  
【注意】８月８日現在、oracle-xe-11.2.0-1.0.x86_64.rpm.zipにしか対応していません
* vagrant upを実行します
* provision.shが実行されてOracleのインストールなどの処理設定が行われます

### provision.shでやってくれること
* OracleXEのインストール
* 文字コードをEUCに変更

## プロビジョニング後の処理
### ユーザーの作成
開発に必要なユーザーを作成します。ユーザー作成用のプロシージャを実行すると簡単に作成できます。
#### 手順
1. ログイン
```Bash
vagrant ssh  
```

* Oracleユーザーになる
```Bash
sudo su -  
su - oracle  
```

* sysユーザーでOracleにログイン
```Bash
sqlplus sys/oracle@127.0.0.1 as sysdba  
```

* 初期化スクリプトを実行
```Bash
@/share/init  
```

* プロシージャを実行
```Bash
call create_develop_user('ユーザー名');    
```
上記のプロシージャで以下のユーザーが作成されます。
    * パスワード認証（パスワードはユーザー名と同じ）
    * developer_commonsロールを付与
        * resourceロール
        * create sessionシステム権限
    * デフォルト表領域はevent
    * 一時表領域はtemp
    * 以下の表領域に対しての無制限のクオータ設定
        * event
        * event_data01
        * event_data02
        * event_idx

### プロシージャ・ファンクションの作成
使用するユーザーでログインして、必要なプロシージャ・ファンクションを作成します。ついては./share/sqlディレクトリをご参照ください。
※多くの場合、以下は必須です（fmcユーザーの例）

1. sqlplusにログイン済みの場合は一度ログアウトする

```Bash
exit
```

* スクリプトの実行

```Bash
sqlplus fmc/fmc@127.0.0.1 @/share/sql/binary_to_euc
sqlplus fmc/fmc@127.0.0.1 @/share/sql/euc_to_binary
```

「めんどくせー！！全部まとめて作成してやるぜーー」の場合はこちら
```Bash
for var in `find /share/sql/*.sql`  
do  
sqlplus mobile/mobile@127.0.0.1 @$var  
done  
```

# その他
sqldeveloperを使うと便利です。
