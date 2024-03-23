hook.Add("MetrostroiLoaded","SectionDelete", function() 	
	for k,v in pairs(Metrostroi.TrainClasses) do
        if v == "gmod_subway_kuzov" then
            Metrostroi.TrainClasses[k] = nil
            Metrostroi.IsTrainClass[v] = nil
		end	
	end
if not Metrostroi.Advanced then return end	
for k,v in pairs(Metrostroi.Advanced.TrainClasses) do
        if v == "gmod_subway_kuzov" then
            Metrostroi.Advanced.TrainClasses[k] = nil
            Metrostroi.Advanced.IsTrainClass[v] = nil
		end	
	end
end)  	
print ("ест")