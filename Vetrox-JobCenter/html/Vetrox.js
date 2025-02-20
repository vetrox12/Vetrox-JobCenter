$(document).ready(function () {
    const VetroxL = (lang) => {
        if (lang === "en") {
            $('body').addClass('ltr');
        } else {
            $('body').removeClass('ltr');
        }
    };    
    const loadLocale = (data) => {
        for (var key in data) {
          var value = data[key];
          if (key.includes("label")) {
            $(`[for='${key.match(/\['for=(.*?)'\]/)[1]}']`).text(value);
          } else {
            $(`.${key}`).html(value);
          }
        }
      };

      function loadJobs(jobs, locales) {
        $(".AllJobs").html("");
    
        jobs.forEach((job, index) => {
            let coordsString = `${job.JobCoords.x}, ${job.JobCoords.y}, ${job.JobCoords.z}`;
            let jobHTML = `
                <div class="Job" data-index="${index}">
                        <span class="JustForLuaInformations" style="display: none; opacity: 0;">
                            <span class="JobNameLua" id="JobNameLua">${job.Job}</span>
                            <span class="CoordsJobLua" id="CoordsJobLua">${coordsString}</span> 
                            <span class="JobGradeLua" id="JobGradeLua">${job.JobGrade}</span>
                        </span>
                    <div class="JobLabel">
                        <span class="icon"><i class="${job.JobLabelIcon}"></i></span>
                        <span class="text">${job.JobLabelText}</span>
                        <span class="hoverJobLabel"></span>
                    </div>
                    <div class="BackgroudForJob" style="display: none;">
                        <span class="JobImage">
                            <img id="JobImageLink" src="${job.JobImageLink}" alt="">
                        </span>
                        <div class="Bio">
                            <span class="TitleOfBioJob">${locales["TitleOfBioJob"]}</span> 
                            <span class="TextOfBioJob">${job.JobBioText}</span>
                        </div>
                        <div class="JobButtons">
                            <span class="TakeTheJob button">${locales["TakeTheJob"]}</span>
                            <span class="GpsTheJob button">${locales["GpsTheJob"]}</span>
                        </div>
                    </div>
                </div>
            `;
            $(".AllJobs").append(jobHTML);
        });
    
        let firstJob = $(".Job").first();
        firstJob.find(".BackgroudForJob").css("display", "block");
        firstJob.find(".hoverJobLabel").addClass("active");
        localStorage.setItem("selectedJob", 0);
        
        $(".TakeTheJob").click(function () {
            let jobElement = $(this).closest(".Job");
            let jobName = jobElement.find(".JobNameLua").text().trim();
            let jobGrade = parseInt(jobElement.find(".JobGradeLua").text().trim());
            $.post(`https://${GetParentResourceName()}/VxChangeJob`, JSON.stringify({ 
                JobLua: jobName, 
                JobGradeLua: jobGrade 
            }));
        });        
           
        $(".GpsTheJob").click(function () {
            let jobElement = $(this).closest(".Job");
            let coords = jobElement.find(".CoordsJobLua").text().trim();
            $.post(`https://${GetParentResourceName()}/MakeWayPoint`, JSON.stringify({ CoordsLua: coords }));
        });
    }
    
      
    var selectedJob = localStorage.getItem('selectedJob');

    if (!selectedJob) {
        var firstJob = $(".Job").first();
        var jobDetails = firstJob.find(".BackgroudForJob");
        var hoverJobLabel = firstJob.find(".hoverJobLabel");
        jobDetails.css('display', 'block');
        hoverJobLabel.addClass("active");

        localStorage.setItem('selectedJob', firstJob.index());
    } else {
        var jobToOpen = $(".Job").eq(selectedJob);
        var jobDetails = jobToOpen.find(".BackgroudForJob");
        var hoverJobLabel = jobToOpen.find(".hoverJobLabel");
        jobDetails.css('display', 'block');
        hoverJobLabel.addClass("active");
    }

    window.addEventListener('message', function(event) {
        if (event.data.CheckUi === "OpenUi") {
            VetroxL(event.data.Language)
            loadLocale(event.data.Locales);
            loadJobs(event.data.Jobs, event.data.Locales);
            $('.VetroxBody').css('display', "block");
        } else if (event.data.CheckUi === 'CloseUi') {
            $('.VetroxBody').css('display', "none");
        }
    });

    $(document).on("click", ".Job", function () {
        $(".BackgroudForJob").css("display", "none");
        $(".hoverJobLabel").removeClass("active");

        let jobDetails = $(this).find(".BackgroudForJob");
        let hoverJobLabel = $(this).find(".hoverJobLabel");

        $(jobDetails).css("display", "block");
        $(hoverJobLabel).addClass("active");

        localStorage.setItem("selectedJob", $(this).data("index"));
    });

    document.onkeyup = function (event) {
        const charCode = event.key;
        if (charCode == "Escape") {
            $.post(`https://${GetParentResourceName()}/VetroxCloseUIToLua`, JSON.stringify({}));
        }
    };
    $(".Exit").click(function() {
        $.post(`https://${GetParentResourceName()}/VetroxCloseUIToLua`, JSON.stringify({}));
    });
});

// Vetrox https://discord.gg/jc3bxNTD9Y