# How to run it?
## 1. Build
```bash
docker build -t hadoop/grzybowa .
```

## 2. Run namenode
```bash
docker network create my-net -d bridge
```

## 3. Run namenode
```bash
docker run -it -p8088:8088 -p9870:9870 --network=my-net --name=nn1 hadoop/grzybowa
```
in container run
```bash
./conf-ssh.sh
passwd
./conf-nn.sh
```

## 4. Run namenode
```bash
docker run -it --network=my-net --name=dn1 hadoop/grzybowa
```
in container run
```bash
./conf-ssh.sh
passwd
./conf-dn.sh
```
