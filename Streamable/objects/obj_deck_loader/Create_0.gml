/// @description Create
var actualStepRate = min(game_get_speed(gamespeed_fps), display_get_frequency())

alarmTiming = actualStepRate / 10 //10 per second

if file_id == -1 {
	instance_destroy()
}

cardsToLoad = []

while !file_text_eof(file_id) {
	var num = file_text_read_real(file_id);
	var lineContent = file_text_readln(file_id);
	//var card = file_text_readln(file_id);
	lineContent = string_replace(lineContent, "\n", "");
	lineContent = string_replace(lineContent, "\r", "");

	//operating on the MTGA format (exportable with moxfield and archidekt.) (TESTED AND FAILED: MTGGOLDFISH <does not use correct set codes>)
	//Archidekt's verbose output includes some weirdness (#x, *F* and *E* for foiling treatments), just filter these if possible
	var collectorNum = -1;
	var setCode = "";

	var splitContents = string_split(lineContent," ");

	var arLen = array_length(splitContents);

	//filter out all "" instances
	var i = 0;
	while (i < arLen)
	{
		//scan through splitComponents and filter out all instances of ""

		if splitContents[i] == ""
		{
			array_delete(splitContents,i,1);
			arLen -=1;
		}
		else
		{
			i+=1;
		}
	}


	//check if its from archidekt

	if splitContents[0] == "x"
	{
		//  its an archidekt list! cull this and process the rest of the entry accordingly
		for (var i = 1; i<arLen; i+=1)
		{

			array_set(splitContents,i-1,splitContents[i]);
		}

		array_delete(splitContents,arLen-1,1);//get that duplicate last piece off
		arLen -=1;
		var trueEndFound = false;
		while not trueEndFound
		{
			//dual purpose, gets the array to the right size and reads the last bit, should be of type string

			var last_entry = string(splitContents[arLen-1]);
			//filter archidekt's foiling (**), categories ([]), and labels (^^)
			if (string_char_at(last_entry,0) == "*" or string_char_at(last_entry,0) == "[" or string_char_at(last_entry,0) == "^")
			{

				array_delete(splitContents,arLen-1,1);//get that duplicate last piece off
				arLen -=1;

			}
			else
			{
				trueEndFound=true;
			}
		}
		//at this point, this entry should be almost equivalent to the moxfield list
	}



	if string_length(string_digits(splitContents[arLen-1])) == string_length(splitContents[arLen-1])
	{
		// last entry is a collector number
		collectorNum = real(splitContents[arLen-1]);
		array_delete(splitContents,arLen-1,1);//get that duplicate last piece off
		arLen -=1;
	}

	if string_char_at(splitContents[arLen-1],0) == "("
	{

		var setCodePiece = splitContents[arLen-1];
		setCode = string_lower(string_replace(string_replace(setCodePiece,"(",""),")",""));

		array_delete(splitContents,arLen-1,1);//get that duplicate last piece off
		arLen -=1;
	}



	var cardName = "!\""+string_compose_from_array(splitContents," ")+"\"";
	splitContents = -1;// santitize and delete the array
	var card = cardName;
	var searchType = "name";
	if collectorNum != -1
	{
		card =card + " cn="+string(collectorNum);
		searchType = "search";
	}

	if setCode != ""
	{
		card =card + " set="+setCode;
		searchType = "search";
	}
	
	var loadData = { "req": card, "spawn_number": real(num), "searchType": searchType }
	
	array_push(cardsToLoad, loadData)
}

file_text_close(file_id)

alarm[0] = alarmTiming
