# Visualize

***Installation***
```
python3 -m venv ./venv
source ./venv/bin/activate
pip3 install -r requirements.txt
```


***Usage***

```
python3 visualize.py  --namespace kubevirt-hyperconverged --conf conf.json --output out
```


# Metrics

> Don't forget to set `KUBECONFIG` and ensure that there is a running prometheus in `openshift-monitoring` namespace. 

```shell
bash metrics.sh
```