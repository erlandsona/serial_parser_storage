if ser.inWaiting():
    input = ser.read(ser.inWaiting())
    j = j + 1

    iline = old_iline + input
    slines = []
    if re.search("\r\n", iline):
        slines = iline.splitlines()

    for sline in slines:
        sline = sline.rstrip()
        if len(sline.split(':')) == 2:
            sline = sline.replace(null, " ")
            sline = str(sline.strip()).split(':')

            if 3 > len(sline[0]) >= 1 and 3 > len(sline[1]) > 1:
                if(sync):
                    data[int(sline[0], 16)+1].append(int(sline[1], 16))
                    if int(sline[0], 16) == 23:
                        i = i + 1
                else:
                    if int(sline[0], 16) == 0:
                        data[int(sline[0], 16)+1].append(int(sline[1], 16))
                        sync = True
            else:
                error = error + 1
