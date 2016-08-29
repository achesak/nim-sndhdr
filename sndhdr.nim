# Nim module for determining the type of sound files.
# Ported from Python's sndhdr module.

# Written by Adam Chesak.
# Released under the MIT open source license.


## nim-sndhdr is a Nim module for determining the type of sound files.
##
## List of detectable formats:
##
## - AIFF (Audio Interchange File Format) format - SoundType.AIFF
## - AIFC (AIFF Compressed) format - SoundType.AIFC
## - AU (Sun audio) format - SoundType.AU
## - HCOM (HCOM Sound Tools) format - SoundType.HCOM
## - VOC (Creative Voice) format - SoundType.VOC
## - 8SVX (8-Bit Sampled Voice) format - SoundType.SVX8
## - SNDT (SndTool) format - SoundType.SNDT
## - SNDR (Sounder) format - SoundType.SNDR
## - FLAC (Free Lossless Audio Codec) format - SoundType.FLAC
## - MIDI (Musical Instrument Digital Interface) format - SoundType.MIDI
## - MP3 (MPEG-1 or MPEG-2 Audio Layer III) format - SoundType.MP3
## - Ogg Vorbis format - SoundType.Vorbis
## - SMUS (IFF Simple Musical Score) format - SoundType.SMUS
## - CMUS (IFF Musical Score) format - SoundType.CMUS
## - VOX (Dialogic ADPCM) format - SoundType.VOX
## - M4A (MPEG-4 Part 14) format - SoundType.M4A
## - WMA (Windows Media Audio) format - SoundType.WMA
## - RA (RealAudio) format - SoundType.RA
## - RA Stream (RealAudio streaming) format - SoundType.RAStream
## - RM Stream (RealMedia streaming) format - SoundType.RMStream
## - DSS (Digital Speech Standard) format - SoundType.DSS
## - DVF (Sony Digital Voice) format - SoundType.DVF
## - AAC (Advanced Audio Coding) format - SoundType.AAC
## - AMR (Adaptive Multi-Rate) format - SoundType.AMR
## - BroadVoice16 format - SoundType.BroadVoice
## - SILK (Skype speech) format - SoundType.SILK
## - G117A (G.117.0 A-law) format - SoundType.G117A
## - G117MU (G.117.0 MU-law) format - SoundType.G117MU
## - iLBC (Internet Low Bitrate Codec) format - SoundType.iLBC
## - Musepack format - SoundType.Musepack
## - Shorten format - SoundType.Shorten
## - ADX (Dreamcast audio) format - SoundType.ADX
## - ACD (Sony Sonic Foundry Acid Music) format - SoundType.ACD
## - CAFF (Apple Core Audio) format - SoundType.CAFF
## - VMD (VocalTec VoIP media) format - SoundType.VMD
## - WMMP (Walkman MP3 container) format - SoundType.WMMP
## - AST (Need for Speed: Underground audio) format - SoundType.AST
## - RMI (Windows Musical Instrument Digital Interface) format - SoundType.RMI
## - QCP (Qualcomm PureVoice) format - SoundType.QCP
## - CD-DA (Compact Disc Digital Audio) format - SoundType.CDDA
## - NES (NES sound) format - SoundType.NES
## - KOZ (Sprint Music Store audio) format - SoundType.KOZ
## - Csound (Csound music) format - SoundType.Csound
## - Undetermined format - SoundType.Other
## - Invalid file or byte sequence (less than 512 bytes) - SoundType.Invalid
##
## (As Nim does not allow for identifier names beginning with digits, the 8SVX format
## has a SoundType of SVX8 instead.)


import os


type SoundType* {.pure.} = enum
    AIFC, AIFF, AU, HCOM, VOC, WAV, SVX8, SNDT, SNDR, FLAC, MIDI, MP3, Vorbis, SMUS, CMUS,
    VOX, M4A, WMA, RA, RAStream, RMStream, DSS, DVF, AAC, AMR, BroadVoice, SILK, G117A,
    G117MU, iLBC, Musepack, Shorten, ADX, ACD, CAFF, VMD, WMMP, AST, RMI, QCP, CDDA, NES,
    KOZ, Csound, Other, Invalid


proc testSound*(data : seq[int8]): SoundType


proc int2ascii(i : seq[int8]): string = 
    ## Converts a sequence of integers into a string containing all of the characters.
    
    let h = high(uint8).int + 1
    
    var s : string = ""
    for j, value in i:
        s = s & chr(value %% h)
    return s



proc `==`(i : seq[int8], s : string): bool = 
    ## Operator for comparing a seq of ints with a string.
    
    return int2ascii(i) == s


proc testAIFC(value : seq[int8]): bool = 
    ## Returns true if the file is an AIFC.
    
    # tests: "FORM" and "AIFC"
    return value[0..3] == "FORM" and value[8..11] == "AIFC"


proc testAIFF(value : seq[int8]): bool = 
    ## Returns true if the file is an AIFF.
    
    # tests: "FORM" and "AIFF"
    return value[0..3] == "FORM" and value[8..11] == "AIFF"


proc testAU(value : seq[int8]): bool = 
    ## Returns true if the file is an AU.
    
    # tests: ".snd" or "dns."
    return value[0..3] == ".snd" or value[0..3] == "dns."


proc testHCOM(value : seq[int8]): bool = 
    ## Returns true if the file is an HCOM.
    
    # tests: "FSSD" or "HCOM"
    return value[65..68] == "FSSD" or value[128..131] == "HCOM"


proc testVOC(value : seq[int8]): bool = 
    ## Returns true if the file is a Creative Voice File.
    
    # tests: "Creative Voice File"
    return value[0..18] == "Creative Voice File"


proc testWAV(value : seq[int8]): bool = 
    ## Returns true if the file is a WAV.
    
    # tests: "RIFF" and "WAVEfmt "
    return value[0..3] == "RIFF" and value[8..15] == "WAVEfmt "


proc test8SVX(value : seq[int8]): bool = 
    ## Returns true if the file is an 8SVX.
    
    # tests: "FORM" and "8SVX"
    return value[0..3] == "FORM" and value[8..11] == "8SVX"


proc testSNDT(value : seq[int8]): bool = 
    ## Returns true if the file is an SNDT.
    
    # tests: "SOUND"
    return value[0..4] == "SOUND"


proc testSNDR(value : seq[int8]): bool = 
    ## Returns true if the file is an SNDR.
    
    # tests: "\0\0"
    return value[0] == 0 and value[1] == 0
    
    
proc testFLAC(value : seq[int8]): bool = 
    ## Returns true if the file is a FLAC.
    
    # tests: "fLaC"
    return value[0..3] == "fLaC"
    

proc testMIDI(value : seq[int8]): bool = 
    ## Returns true if the file is a MIDI.
    
    # tests: "MThd"
    return value[0..3] == "MThd"


proc testMP3(value : seq[int8]): bool = 
    ## Returns true if the file is an MP3.
    
    # tests: "ID3" or (FF and FB)
    return value[0..2] == "ID3" or (value[0] == 255 and value[1] == 251)


proc testVorbis(value : seq[int8]): bool = 
    ## Returns true if the file is an Ogg Vorbis.
    
    # tests: "OggS"
    return value[0..3] == "OggS"


proc testSMUS(value : seq[int8]): bool = 
    ## Returns true if the file is an IFF Simple Musical Score.
    
    # tests: "FORM" and "SMUS"
    return value[0..3] == "FORM" and value[8..11] == "SMUS"


proc testCMUS(value : seq[int8]): bool = 
    ## Returns true if the file is an IFF Musical Score.
    
    # tests: "FORM" and "CMUS"
    return value[0..3] == "FORM" and value[8..11] == "CMUS"


proc testVOX(value : seq[int8]): bool = 
    ## Returns true if the file is Dialogic ADPCM (VOX).
    
    # tests: "VOX "
    return value[0..3] == "VOX "


proc testM4A(value : seq[int8]): bool = 
    ## Returns true if the file is an M4A.
    
    # tests: " ftypM4A "
    return value[3..11] == " ftypM4A "


proc testWMA(value : seq[int8]): bool = 
    ## Returns true if the file is a WMA.
    
    # tests: 30 26 B2 75 8E 66 CF 11 A6 D9 00 AA 00 62 CE 6C
    return value[0] == 48 and value[1] == 38 and value[2] == 178 and value[3] == 117 and value[4] == 142 and value[5] == 102 and value[6] == 207 and 
           value[7] == 17 and value[8] == 166 and value[9] == 217 and value[10] == 0 and value[11] == 170 and value[12] == 0 and value[13] == 98 and
           value[14] == 206 and value[15] == 108 # Well that was long


proc testRA(value : seq[int8]): bool = 
    ## Returns true if the file is a RealAudio file.
    
    # tests: ".RMF" and 00 00 00 12 00
    return value[0..3] == ".RMF" and value[4] == 0 and value[5] == 0 and value[6] == 0 and value[7] == 18 and value[8] == 0


proc testRAStream(value : seq[int8]): bool = 
    ## Returns true if the file is a RealAudio streaming file.
    
    # tests: ".ra" and FD 00
    return value[0..2] == ".ra" and value[3] == 253 and value[4] == 0


proc testRMStream(value : seq[int8]): bool = 
    ## Returns true if the file is a RealMedia streaming file.
    
    # tests: ".RMF"
    return value[0..3] == ".RMF"


proc testDSS(value : seq[int8]): bool = 
    ## Returns true if the file is a DSS.
    
    # tests: ".dss"
    return value[0..3] == ".dss"


proc testDVF(value : seq[int8]): bool = 
    ## Returns true if the file is a Sony Digital Voice File.
    
    # tests: "MS_VOICE"
    return value[0..7] == "MS_VOICE"


proc testAAC(value : seq[int8]): bool = 
    ## Returns true if the file is an AAC.
    
    # tests: (FF F9) or (FF F1)
    return value[0] == 255 and (value[1] == 249 or value[1] == 241)


proc testAMR(value : seq[int8]): bool = 
    ## Returns true if the file is an AMR.
    
    # tests: "#!AMR"
    return value[0..4] == "#!AMR"


proc testBroadVoice(value : seq[int8]): bool = 
    ## Returns true if the file is a BroadVoice16.
    
    # tests: "#!BV16\n"
    return value[0..6] == "#!BV16\n"


proc testSILK(value : seq[int8]): bool = 
    ## Returns true if the file is a SILK.
    
    # tests: "#!SILK\n"
    return value[0..6] == "#!SILK\n"


proc testG117A(value : seq[int8]): bool = 
    ## Returns true if the file is a G.117.0 A-law.
    
    # tests: "#!G7110A\n"
    return value[0..8] == "#!G7110A\n"


proc testG117MU(value : seq[int8]): bool = 
    ## Returns true if the file is a G.117.0 MU-law.
    
    # tests: "#!G7110M\n"
    return value[0..8] == "#!G7110M\n"


proc testiLBC(value : seq[int8]): bool = 
    ## Returns true if the file is an iLBC.
    
    # tests: "#!iLBC30\n" or "#!iLBC20\n"
    return value[0..8] == "#!iLBC30\n" or value[0..8] == "#!iLBC20\n"


proc testMusepack(value : seq[int8]): bool = 
    ## Returns true if the file is a Musepack.
    
    # tests: "MPCK" or "MP+"
    return value[0..3] == "MPCK" or value[0..2] == "MP+"


proc testShorten(value : seq[int8]): bool = 
    ## Returns true if the file is a Shorten.
    
    # tests: "ajkg"
    return value[0..3] == "ajkg"


proc testADX(value : seq[int8]): bool = 
   ## Returns true if the file is an ADX (Dreamcast audio file).
   
   # tests: 80 00 00 20 03 12 04
   return value[0] == 128 and value[1] == 0 and value[2] == 0 and value[3] == 32 and value[4] == 3 and value[5] == 18 and value[6] == 4


proc testACD(value : seq[int8]): bool = 
    ## Returns true if the file is a Sony Sonic Foundry Acid Music File.
    
    # tests: "riff"
    return value[0..3] == "riff"


proc testCAFF(value : seq[int8]): bool = 
    ## Returns true if the file is an Apple Core Audio File.
    
    # tests: "caff"
    return value[0..3] == "caff"


proc testVMD(value : seq[int8]): bool = 
    ## Returns true if the file is a VocalTec VoIP media file.
    
    # tests: "[VMD]"
    return value[0..4] == "[VMD]"


proc testWMMP(value : seq[int8]): bool = 
    ## Returns true if the file is a Walkman MP3 container file.
    
    # tests: "WMMP"
    return value[0..3] == "WMMP"


proc testAST(value : seq[int8]): bool = 
    ## Returns true if the file is a Need for Speed: Underground Audio file.
    
    # tests: "SCH1"
    return value[0..3] == "SCH1"


proc testRMI(value : seq[int8]): bool = 
    ## Returns true if the file is a Windows Musical Instrument Digital Interface file.
    
    # tests: "RIFF" and "RMIDdata"
    return value[0..3] == "RIFF" and value[8..15] == "RMIDdata"


proc testQCP(value : seq[int8]): bool = 
    ## Returns true if the file is a Qualcomm PureVoice file.
    
    # tests: "RIFF" and "QLCMfmt"
    return value[0..3] == "RIFF" and value[8..14] == "QLCMfmt"


proc testCDDA(value : seq[int8]): bool = 
    ## Returns true if the file is a Compact Disc Digital Audio (CD-DA) file.
    
    # tests: "RIFF" and "CDDAfmt"
    return value[0..3] == "RIFF" and value[8..14] == "CDDAfmt"


proc testNES(value : seq[int8]): bool = 
    ## Returns true if the file is a NES sound file.
    
    # tests: "NESM and 1A 01
    return value[0..3] == "NESM" and value[4] == 26 and value[5] == 1


proc testKOZ(value : seq[int8]): bool = 
    ## Returns true if the file is a Sprint Music Store audio file.
    
    # tests: "ID3" and 03 00 00 00
    return value[0..2] == "ID3" and value[3] == 3 and value[4] == 0 and value[5] == 0 and value[6] == 0


proc testCsound(value : seq[int8]): bool = 
    ## Returns true if the file is a Csound music file.
    
    # tests: "<CsoundSynthesiz"
    return value[0..15] == "<CsoundSynthesiz"


proc testSound*(file : File): SoundType = 
    ## Determines the format of the sound file given.
    
    var data = newSeq[int8](512)
    var b : int = file.readBytes(data, 0, 512)
    if b < 512:
        return SoundType.Invalid
    return testSound(data)


proc testSound*(filename : string): SoundType = 
    ## Determines the format of the sound file with the specified filename.
    
    var file : File = open(filename)
    var format : SoundType = testSound(file)
    file.close()
    return format


proc testSound*(data : seq[int8]): SoundType = 
    ## Determines the format of the sound file from the bytes given.
    
    if len(data) < 512:
        return SoundType.Invalid
    elif testAIFC(data):
        return SoundType.AIFC
    elif testAIFF(data):
        return SoundType.AIFF
    elif testAU(data):
        return SoundType.AU
    elif testHCOM(data):
        return SoundType.HCOM
    elif testVOC(data):
        return SoundType.VOC
    elif testWAV(data):
        return SoundType.WAV
    elif test8SVX(data):
        return SoundType.SVX8
    elif testSNDT(data):
        return SoundType.SNDT
    elif testSNDR(data):
        return SoundType.SNDR
    elif testFLAC(data):
        return SoundType.FLAC
    elif testMIDI(data):
        return SoundType.MIDI
    elif testMP3(data):
        return SoundType.MP3
    elif testVorbis(data):
        return SoundType.Vorbis
    elif testSMUS(data):
        return SoundType.SMUS
    elif testCMUS(data):
        return SoundType.CMUS
    elif testVOX(data):
        return SoundType.VOX
    elif testM4A(data):
        return SoundType.M4A
    elif testWMA(data):
        return SoundType.WMA
    elif testRA(data):
        return SoundType.RA
    elif testRAStream(data):
        return SoundType.RAStream
    elif testRMStream(data):
        return SoundType.RMStream
    elif testDSS(data):
        return SoundType.DSS
    elif testDVF(data):
        return SoundType.DVF
    elif testAAC(data):
        return SoundType.AAC
    elif testAMR(data):
        return SoundType.AMR
    elif testBroadVoice(data):
        return SoundType.BroadVoice
    elif testSILK(data):
        return SoundType.SILK
    elif testG117A(data):
        return SoundType.G117A
    elif testG117MU(data):
        return SoundType.G117MU
    elif testiLBC(data):
        return SoundType.iLBC
    elif testMusepack(data):
        return SoundType.Musepack
    elif testShorten(data):
        return SoundType.Shorten
    elif testADX(data):
        return SoundType.ADX
    elif testACD(data):
        return SoundType.ACD
    elif testCAFF(data):
        return SoundType.CAFF
    elif testVMD(data):
        return SoundType.VMD
    elif testWMMP(data):
        return SoundType.WMMP
    elif testAST(data):
        return SoundType.AST
    elif testRMI(data):
        return SoundType.RMI
    elif testQCP(data):
        return SoundType.QCP
    elif testCDDA(data):
        return SoundType.CDDA
    elif testNES(data):
        return SoundType.NES
    elif testKOZ(data):
        return SoundType.KOZ
    elif testCsound(data):
        return SoundType.Csound
    else:
        return SoundType.Other


# When run as it's own program, determine the type of the provided sound file:
when isMainModule:
    
    if paramCount() < 2:
        echo("Invalid number of parameters. Usage:\nsndhdr [filename1] [filename2] ...")
    
    for i in 1..paramCount():
        echo("Detected file type for \"" & paramStr(i) & "\": " & $testSound(paramStr(i)))