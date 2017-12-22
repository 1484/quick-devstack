# quick-devstack

## 前提条件

書籍初版発行時は Ubuntu 14.04 で動きましたが、現在は Ubuntu 16.04 での動作を確認していますので、適当にインストールしてください。

必要スペックは、書籍の中ではコントローラーはメモリー 4GB、コンピュートは8GBくらいを推奨しています。
これは本の演習の中で複数台のVMを起動することを想定しているためです。
最小構成としては、 2 vCPU、メモリー 2〜4GB、HDD 8GB くらいで可能です。
メモリー 2GBだとスワップが発生しますが、動作が遅くなる程度で実用に支障はないでしょう。

仮想マシンを３台使う前提です。

以下のアドレスが割り当てられていることが前提になります。

* コントローラーノードstack01 192.168.100.10
  * NIC 2個で同じネットワークに接続されていること。
  * 1個にアドレスを割り当てる。
  * もう1個はそのままする。br-ex に接続される）
* コンピュートノード#1 stack02 192.168.100.11 (NIC 1個)
* コンピュートノード#2 stack03 192.168.100.12 (NIC 1個)

## 実行方法

コントローラーノードで実行します。

```
git clone https://github.com/josug-book1-materials/quick-devstack.git
cd quick-devstack
./stack01/setup.sh
cd ~/devstack
./stack.sh
```

終わったら再起動しないで次へ進みます。

コンピュートのノードで実行します。
1台目→ 2台目の順に実行します。

```
git clone https://github.com/josug-book1-materials/quick-devstack.git
cd quick-devstack
./stack02/setup.sh  # 2台目のコンピュートノードは ./stack03/setup.sh
cd ~/devstack
./stack.sh
```
終わったら再起動しないで次へ進みます。

最後に、全体の設定 (devstack後の各種設定) を行います (詳しくはスクリプトを確認してください)
コントローラーで以下を実行します。
```
cd ~/quick-devstack
./stack01/post-stack.sh
```

準備できたら http://www.amazon.co.jp/dp/4798139785 の演習を実施する。
