for i in frconfig ds dsadmin openam amster openidm postgres-openidm openig forgerock-metrics gatling-benchmark web end-user-ui
do
   helm package --version $1 --app-version $1 $i
done
for i in *.tgz
do
   echo $i
   az acr helm push -n ForgeRockContainer1 $i
done
rm *.tgz
