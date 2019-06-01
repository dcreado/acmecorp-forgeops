for i in frconfig ds dsadmin openam amster openidm postgres-openidm openig forgerock-metrics gatling-benchmark web end-user-ui
helm package --app-version $1 $i
for i in *.tgz
do
   echo $i
   az acr helm push -n ForgeRockContainer1 $i
done
rm *.tgz
