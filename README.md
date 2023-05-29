# DASL DEMO

DASL DEMOのDocker Build


## ビルドプロセス

### Build & Run
* ```docker-compose up -d --build```

## セットアップ

DASLのセットアップは、インタラクティブなため、完全に自動化できないので、コンテナ起動後、以下のような手動による設定が必要

```>zn "USER"```

```>do ^%DAINIT```

DASLの初期化時にアプリケーションパラメータにapplication-params.pngに表示されているものと同じ内容を入力

```>set IO = "/intersystems/iris/dasl/dsmdasl_demo-utf8.sav"```

```>do UTF8^%DALOAD```

## 起動方法

### ADBOOK

```>do ^%DAS```

```Screen: ADBOOK```

表示されるスクリーンの名前の所に＊を入力すると、候補が複数でてくるので、適当に１つを選択


### 管理ポータル

[localhost:52774/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS](http://localhost:52774/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS)


##　ローカルセットアップ


src/setupの下のDASL.Utility.clsをDASLをセットアップしたいネームスペースにロードする

```>set file = "C:\git\dasl\src\setup\DASL\utility.cls"```

```>do $System.OBJ.Load(file,"ck",,1)```

```>set dir = "c:\git\dasl"```

```>write ##class(DASL.Utility).SetupLocal(dir)```

DASLの初期化時にアプリケーションパラメータにapplication-params.pngに表示されているものと同じ内容を入力
