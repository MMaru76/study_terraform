URL="https://tabiya.jp"; #接続先
HEAD="Content-Type:text/xml"; #リクエストヘッダー
DIR="bc_curl"; #結果保存先ディレクトリ

for i in {0..4}
do
    SETDT=`date "+%Y%m%d%H%M%S"`
    # SETDT=`date "+%Y%m%d%H"`
    curl -H $HEAD $URL > $DIR/oreo_$SETDT.txt;
    # curl -H $HEAD $URL;
    sleep 1;
done
