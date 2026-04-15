#!/bin/bash

# ====== إعدادات ======
NODES=("100.125.198.27" "100.121.124.32")
USER="berlanti"
NODE_NAME="NodeA"
PASSWORD="1234"

RESTORE_DIR=~/Project/restore_tmp
mkdir -p $RESTORE_DIR

FOUND=0

echo "📥 Searching for backup across nodes..."

# ====== البحث ======
for NODE_IP in "${NODES[@]}"
do
    echo "🔍 Checking node $NODE_IP ..."

    EXISTS=$(ssh $USER@$NODE_IP "[ -f ~/Project/storage/$NODE_NAME/backup.enc ] && echo yes")

    if [ "$EXISTS" == "yes" ]; then
        echo "✅ Found backup on $NODE_IP"

        scp $USER@$NODE_IP:~/Project/storage/$NODE_NAME/backup.enc $RESTORE_DIR/
        FOUND=1
        break
    fi
done

# ====== إذا ما لقينا ======
if [ $FOUND -eq 0 ]; then
    echo "❌ No backup found on any node!"
    exit 1
fi

cd $RESTORE_DIR

# ====== فك التشفير ======
echo "🔐 Decrypting..."
openssl enc -aes-256-cbc -d -pbkdf2 -in backup.enc -out backup.tar.gz -k $PASSWORD

if [ $? -ne 0 ]; then
    echo "❌ Decryption failed!"
    exit 1
fi

# ====== فك الضغط ======
echo "📂 Extracting..."
mkdir -p ~/Project/data_restored
tar -xzf backup.tar.gz -C ~/Project/data_restored/

echo "✅ Restore completed from node $NODE_IP"

rm -r $RESTORE_DIR
