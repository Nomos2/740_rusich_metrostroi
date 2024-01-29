hook.Add("MetrostroiLoaded","SectionDelete", function() 	
	for k,v in pairs(Metrostroi.TrainClasses) do
        if v == "gmod_subway_kuzov" then
            Metrostroi.TrainClasses[k] = nil
            Metrostroi.IsTrainClass[v] = nil
		end	
	end 
end)