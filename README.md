# horovod-helm


## Deployment

1. Download and extract descriptor files:
```
wget https://krajflix.v4y.hu:9943/root/horovod-helm/-/archive/main/horovod-helm-main.tar --no-check-certificate
tar -xvf horovod-helm-main.tar 
```

Enter the directory of OpenStack descriptors:
```
cd horovod-helm-main.tar/terraform
```
Customize OpenStack descriptors:


An application credential and your authentication URL is needed to enable Terraform to access your resources

You can create an application credential on the OpenStack web interface under Identity > Application Credentials. Please note that application credentials are valid only for the project selected at the time of their creation.
You can find your authentication URL under Project > API Access, as the endpoint of the entry labeled 'Identity'

```
auth_data = ({
    credential_id= "SET_YOUR_CREDENTIAL_ID"
    credential_secret= "SET_YOUR_CREDENTIAL_SECRET"
    auth_url = "SET_YOUR_AUTH_URL"
})
```

In the auth_data.auto.tfvars file, authentication information must be set according to the following format:
```
eval $(ssh-agent -s) && echo "$(cat /root/id_rsa)" | tr -d '\r' | ssh-add -


```