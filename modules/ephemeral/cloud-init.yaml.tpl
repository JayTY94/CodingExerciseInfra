#cloud-config
package_update: true
packages:
  - cifs-utils
  - curl
  - vim 
  - nano

runcmd:
  - mkdir -p /mnt/exercism
  - mount -t cifs //${storage_account_name}.file.core.windows.net/${share_name} /mnt/exercism -o vers=3.0,username=${storage_account_name},password=${storage_account_key},dir_mode=0777,file_mode=0777,serverino
  - cd /tmp
  - curl -L -o exercism.tar.gz https://github.com/exercism/cli/releases/download/v3.5.5/exercism-3.5.5-linux-x86_64.tar.gz
  - tar -xzf exercism.tar.gz
  - mv exercism /usr/local/bin/
  - runuser -l azureuser -c 'exercism configure --workspace=/mnt/exercism --token=${exercism_token}'
  - runuser -l azureuser -c "echo 'export PATH=\$PATH:/usr/local/bin' >> ~/.bashrc"
