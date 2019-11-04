# helloworld-go

Simple hello world go web application

## Build

```bash
go build
```

## Run

```bash
./helloworld-go
```

### Test Local

```bash
$ curl localhost:8080/api/v1/message
Go is the best language in the world
```

## Docker

```bash
docker build . -t helloworld-go
```

## Run Docker Container

```bash
docker run -p 8080:8080 helloworld-go
```

### Test Docker Container

```bash
$ curl localhost:8080/api/v1/message
Go is the best language in the world
```

## Tag and Push Docker Image

```bash
$ docker tag helloworld-go:1.0 nickdala/helloworld-go:1.0

$ docker push nickdala/helloworld-go:1.0
```

## Deploy to Kubernetes

```bash
kubectl apply -f kubernetes/helloworld-v1.yaml
```

## Gateway

To allow ‘ingress' traffic to reach the mesh we need to create a ‘Gateway' (to configure a load balancer) and a ‘VirtualService' (which controls the forwarding of traffic from the gateway to our services).

```
kubectl apply -f kubernetes/helloworld-all-v1.yaml
```

```
kubectl get services
kubectl get pods
```

Get the gateway external IP

```
kubectl get svc istio-ingressgateway -n istio-system
```

```
export GATEWAY_URL=<EXTERNAL IP>
```

```
$ curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/api/v1/message
200

$ curl http://${GATEWAY_URL}/api/v1/message
Go is the best language in the world
```

```
while :; do curl http://$GATEWAY_URL/api/v1/message; sleep 2; done
```

Change the message and deploy version 2

```
docker build . -t helloworld-go:2.0
docker tag helloworld-go:2.0 nickdala/helloworld-go:2.0
docker push nickdala/helloworld-go:2.0
```

```
kubectl apply -f helloworld-v2.yaml
kubectl apply -f helloworld-50-50.yaml
```

```
while :; do curl http://$GATEWAY_URL/api/v1/message; sleep 2; done
```