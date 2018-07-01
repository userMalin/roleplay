
function saveLog(file, text)
{
    local myfile = io.file("Database/Logs/"+file, "a+");
    if (myfile.isOpen)
    {
		local data = date();
	    local datas = data.day+"/"+data.month+" "+data.hour+":"+data.min;
        myfile.write(datas+" || "+text + " \n");
        myfile.close();
    }
    else
	{
        print(myfile.errorMsg)	
	}
};