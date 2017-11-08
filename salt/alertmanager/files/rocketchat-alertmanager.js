class Script {
    process_incoming_request({
        request
    }) {
        var alertColor = "warning";
        var title = "Prometheus notification";

        if (request.content.status == "resolved") {
            alertColor = "good";
            title = "Prometheus alert resolved";
        } else if (request.content.status == "firing") {
            alertColor = "danger";
            title = "Prometheus alert triggered";
        }
        console.log(request.content);

        let finFields = [];
        for (i = 0; i < request.content.alerts.length; i++) {
            var endVal = request.content.alerts[i];
            var elem = {
                title: "alertname: " + endVal.labels.alertname,
                value: "*instance:* " + endVal.labels.instance,
                short: false
            };

            finFields.push(elem);
            finFields.push({title: "description", value: endVal.annotations.description});
            finFields.push({title: "summary", value: endVal.annotations.summary});
        }



        return {
            content: {

                username: "Prometheus Alert",
                attachments: [{
                    color: alertColor,
                    title_link: request.content.externalURL,
                    title: title,
                    fields: finFields,

                }]

            }
        };

        return {
            error: {
                success: false
            }
        };
    }
}

