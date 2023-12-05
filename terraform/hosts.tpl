[k8s_master]
%{ for ip in k8s_master ~}
${ip}
%{ endfor ~}

[k8s_worker]
%{ for ip in k8s_worker ~}
${ip}
%{ endfor ~}

[nfs]
%{ for ip in nfs ~}
${ip}
%{ endfor ~}