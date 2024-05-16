# Web Server on localhost

Web Server is hosted on kubernetes pod using a multicontainer setup. The web container has an nginx image that hosts the site. The sidecar container has a busybox image that pulls in the latest commit of the [landing page](https://github.com/Abhinaenae/abhi-homelab/blob/main/scripts/web%20server/index.html) html file every 15 seconds and stores it into the shared volume to be used by the webcontainer. I port-forwarded 8080 to map to 80, allowing the page to be visible on localhost:8080.

I used a declarative approach by creating a YAML file, [web.yaml](https://github.com/Abhinaenae/abhi-homelab/blob/main/scripts/web%20server/web.yaml):
```
apiVersion: v1
kind: Pod
metadata:
  name: multicontainer
spec:
  containers:
  - name: webcontainer                           # container name: webcontainer
    image: nginx                                 # image from nginx
    ports:                                       # opening-port: 80
      - containerPort: 80
    volumeMounts:
    - name: sharedvolume                          
      mountPath: /usr/share/nginx/html          # path in the container
  - name: sidecarcontainer
    image: busybox                              # sidecar, second container image is busybox
    command: ["/bin/sh"]                        # it pulls index.html file from github every 15 seconds
    args: ["-c", "while true; do wget -O /var/log/index.html https://raw.githubusercontent.com/Abhinaenae/abhi-homelab/blob/main/scripts/web%20server/index.html; sleep 15; done"]
    volumeMounts:
    - name: sharedvolume
      mountPath: /var/log
  volumes:                                      # define emptydir temporary volume, when the pod is deleted, volume also deleted
  - name: sharedvolume                          # name of volume 
    emptyDir: {}                                # volume type emtpydir: creates empty directory where the pod is runnning
```

Commands run:
```
kubectl apply -f web.yaml
kubectl port-forward pod/multicontainer 8080:80
```

![image](https://github.com/Abhinaenae/abhi-homelab/assets/92381984/27a08521-1720-45ab-89dc-597f13332aba)

