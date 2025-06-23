#cloud-config
package_update: true
packages:
  - cifs-utils
  - curl

runcmd:
  - mkdir -p /mnt/exercism
  - mount -t cifs //${storage_account_name}.file.core.windows.net/${share_name} /mnt/exercism -o vers=3.0,username=${storage_account_name},password=${storage_account_key},dir_mode=0777,file_mode=0777,serverino
  - su - azureuser -c "curl -sSL https://exercism.org/install | bash"
  - su - azureuser -c "/home/azureuser/.bin/exercism configure --workspace=/mnt/exercism --token=${exercism_token}"
  - echo 'export PATH=$PATH:$HOME/.bin' >> /home/azureuser/.bashrc
