#!/bin/bash


SOURCE_DIR=~/Project/data
TMP_DIR=~/Project/tmp_backup
NODES=("100.125.198.27" "100.121.124.32")
USER="berlanti"
NODE_NAME="NodeA"
PASSWORD="1234"

mkdir -p $TMP_DIR

echo "🔄 Starting Backup..."

# ====== مزامنة (نسخة محدثة فقط) ======
DEST_DIR=~/Project/backup/latest
mkdir -p $DEST_DIR

rsync -av --delete --checksum $SOURCE_DIR/ $DEST_DIR/

# ====== ضغط ======
ARCHIVE=$TMP_DIR/backup.tar.gz
tar -czf $ARCHIVE -C $DEST_DIR .

# ====== تشفير ======
ENC_FILE=$TMP_DIR/backup.enc
openssl enc -aes-256-cbc -salt -pbkdf2 -in $ARCHIVE -out $ENC_FILE -k $PASSWORD

# ====== إرسال ======
for NODE in "${NODES[@]}"
do
    echo "📡 Sending to $NODE ..."

    ssh $USER@$NODE "mkdir -p ~/Project/storage/$NODE_NAME"

    scp $ENC_FILE $USER@$NODE:~/Project/storage/$NODE_NAME/backup.enc
done

echo "✅ Backup completed!"

rm -r $TMP_DIR
