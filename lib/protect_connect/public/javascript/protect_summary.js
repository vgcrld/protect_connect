(function () {

    var myConnector = tableau.makeConnector();

    myConnector.getSchema = function (schemaCallback) {

      var cols = [
        { id: "start_time",         dataType: tableau.dataTypeEnum.datetime },
        { id: "end_time",           dataType: tableau.dataTypeEnum.datetime },
        { id: "activity",           dataType: tableau.dataTypeEnum.string },
        { id: "number",             dataType: tableau.dataTypeEnum.string },
        { id: "entity",             dataType: tableau.dataTypeEnum.string },
        { id: "commmeth",           dataType: tableau.dataTypeEnum.string },
        { id: "address",            dataType: tableau.dataTypeEnum.string },
        { id: "schedule_name",      dataType: tableau.dataTypeEnum.string },
        { id: "examined",           dataType: tableau.dataTypeEnum.float },
        { id: "affected",           dataType: tableau.dataTypeEnum.float },
        { id: "failed",             dataType: tableau.dataTypeEnum.float },
        { id: "bytes",              dataType: tableau.dataTypeEnum.float },
        { id: "bytes_protected",    dataType: tableau.dataTypeEnum.float },
        { id: "bytes_written",      dataType: tableau.dataTypeEnum.float },
        { id: "dedup_savings",      dataType: tableau.dataTypeEnum.float },
        { id: "comp_savings",       dataType: tableau.dataTypeEnum.float },
        { id: "idle",               dataType: tableau.dataTypeEnum.float },
        { id: "mediaw",             dataType: tableau.dataTypeEnum.float },
        { id: "processes",          dataType: tableau.dataTypeEnum.float },
        { id: "successful",         dataType: tableau.dataTypeEnum.string },
        { id: "volume_name",        dataType: tableau.dataTypeEnum.string },
        { id: "drive_name",         dataType: tableau.dataTypeEnum.string },
        { id: "library_name",       dataType: tableau.dataTypeEnum.string },
        { id: "last_use",           dataType: tableau.dataTypeEnum.string },
        { id: "comm_wait",          dataType: tableau.dataTypeEnum.float },
        { id: "num_offsite_vols",   dataType: tableau.dataTypeEnum.float }
      ];

      var tableSchema = {
          id: "spsummary",
          alias: "Spectrum Protect Summary Data",
          columns: cols
      };

      schemaCallback([tableSchema]);
      
    };

    myConnector.getData = function(table, doneCallback) {
      $.getJSON("http://localhost:8080/summary", function(resp) {
        var start = resp['START_TIME'],
            tableData = [];

        // Interate over each feat key
         for (var i = 0, len = start.length; i < len; i++) {
             tableData.push({
               "start_time":       resp['START_TIME'][i],
               "end_time":         resp['END_TIME'][i],
               "activity":         resp['ACTIVITY'][i],  
               "number":           resp['NUMBER'][i],
               "entity":           resp['ENTITY'][i],
               "commmeth":         resp['COMMMETH'][i],
               "address":          resp['ADDRESS'][i],
               "schedule_name":    resp['SCHEDULE_NAME'][i],
               "examined":         resp['EXAMINED'][i],
               "affected":         resp['AFFECTED'][i],
               "failed":           resp['FAILED'][i],
               "bytes":            resp['BYTES'][i],
               "bytes_protected":  resp['BYTES_PROTECTED'][i],
               "bytes_written":    resp['BYTES_WRITTEN'][i],
               "dedup_savings":    resp['DEDUP_SAVINGS'][i],
               "comp_savings":     resp['COMP_SAVINGS'][i],
               "idle":             resp['IDLE'][i],
               "mediaw":           resp['MEDIAW'][i],
               "processes":        resp['PROCESSES'][i],
               "successful":       resp['SUCCESSFUL'][i],
               "volume_name":      resp['VOLUME_NAME'][i],
               "drive_name":       resp['DRIVE_NAME'][i],
               "library_name":     resp['LIBRARY_NAME'][i],
               "last_use":         resp['LAST_USE'][i],
               "comm_wait":        resp['COMM_WAIT'][i],
               "num_offsite_vols": resp['NUM_OFFSITE_VOLS'][i]
             });
         }

        table.appendRows(tableData);
        doneCallback();
      });
    };

    tableau.registerConnector(myConnector);

    $(document).ready(function () {
      $("#submitButton").click(function () {
          tableau.connectionName = "SpectrumProect Summary Data";
          tableau.submit();
      });
    });


})();
