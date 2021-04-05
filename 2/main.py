import requests
import sys
from requests.packages.urllib3 import Retry

class Instance:
    PrivateIp = 1
    InstanceId = 2
    InstanceType = 3
    AccountId = 4
    ImageId = 5
    Region = 6
    AvailabilityZone = 7
    Architecture = 8

def getInstanceMetadata():
    linkLocalAddress = "http://169.254.169.254/"
    instanceIdentityUrl = linkLocalAddress + "latest/dynamic/instance-identity/document"
    session = requests.Session()
    retries = Retry(total=3, backoff_factor=0.3)
    metadataAdapter = requests.adapters.HTTPAdapter(max_retries=retries)
    session.mount(linkLocalAddress, metadataAdapter)
    try:
        r = requests.get(instanceIdentityUrl, timeout=(2, 5))
    except (requests.exceptions.ConnectTimeout, requests.exceptions.ConnectionError) as err:
        print("Connection to AWS EC2 Metadata timed out: " + str(err.__class__.__name__))
        print("Is this an EC2 instance? Is the AWS metadata endpoint blocked? " + linkLocalAddress)
        sys.exit(1)
    
    return r.json()

def getInstanceRegion():
    return getInstanceMetadata().get(Instance.Region)

def getInstanceAZ():
    return getInstanceMetadata().get(Instance.AvailabilityZone)

...