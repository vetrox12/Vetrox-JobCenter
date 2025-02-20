RegisterNetEvent("CJobWiWi", function(jobName, JobGrade)
    exports[Exports.core]:GetCoreObject().Functions.GetPlayer(source).Functions.SetJob(jobName, JobGrade)
end)

-- Vetrox https://discord.gg/jc3bxNTD9Y