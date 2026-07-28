
#!/bin/bash


URL="http://127.0.0.1:8000/"


STATUS=$(curl -s $URL)


if [[ $STATUS == *"ONLINE"* ]]

then

echo "MUTEB SOC HEALTHY"

else

echo "MUTEB SOC DOWN"

fi

