# Nimrod module for determining the type of sound files.
# Ported from Python's sndhdr module.

# Written by Adam Chesak.
# Released under the MIT open source license.


## nimrod-sndhdr is a Nimrod module for determining the type of sound files.
##
## List of detected formats:
##
## - AIFF (Audio Interchange File Format) format - TSoundType.AIFF
## - AIFC (AIFF Compressed) format - TSoundType.AIFC
## - AU (Sun audio) format - TSoundType.AU
## - HCOM (HCOM Sound Tools) format - TSoundType.HCOM
## - VOC (Creative Voice) format - TSoundType.VOC
## - 8SVX (8-Bit Sampled Voice) format - TSoundType.SVX8
## - SNDT (SndTool) format - TSoundType.SNDT
## - SNDR (Sounder) format - TSoundType.SNDR
## - FLAC (Free Lossless Audio Codec) format - TSoundType.FLAC
## - MIDI (Musical Instrument Digital Interface) format - TSoundType.MIDI
## - MP3 (MPEG-1 or MPEG-2 Audio Layer III) format - TSoundType.MP3
## - Ogg Vorbis format - TSoundType.Vorbis
## - SMUS (IFF Simple Musical Score) format - TSoundType.SMUS
## - CMUS (IFF Musical Score) format - TSoundType.CMUS
## - VOX (Dialogic ADPCM) format - TSoundType.VOX
## - M4A (MPEG-4 Part 14) format - TSoundType.M4A
## - WMA (Windows Media Audio) format - TSoundType.WMA
## - RA (RealAudio) format - TSoundType.RA
## - RA Stream (RealAudio streaming) format - TSoundType.RAStream
## - RM Stream (RealMedia streaming) format - TSoundType.RMStream
## - DSS (Digital Speech Standard) format - TSoundType.DSS
## - DVF (Sony Digital Voice) format - TSoundType.DVF
## - AAC (Advanced Audio Coding) format - TSoundType.AAC
## - AMR (Adaptive Multi-Rate) format - TSoundType.AMR
## - BroadVoice16 format - TSoundType.BroadVoice
## - SILK (Skype speech) format - TSoundType.SILK
## - G117A (G.117.0 A-law) format - TSoundType.G117A
## - G117MU (G.117.0 MU-law) format - TSoundType.G117MU
## - iLBC (Internet Low Bitrate Codec) format - TSoundType.iLBC
## - Musepack format - TSoundType.Musepack
## - Shorten format - TSoundType.Shorten
## - ADX (Dreamcast audio) format - TSoundType.ADX
## - ACD (Sony Sonic Foundry Acid Music) format - TSoundType.ACD
## - CAFF (Apple Core Audio) format - TSoundType.CAFF
## - VMD (VocalTec VoIP media) format - TSoundType.VMD
## - WMMP (Walkman MP3 container) format - TSoundType.WMMP
## - AST (Need for Speed: Underground audio) format - TSoundType.AST
## - RMI (Windows Musical Instrument Digital Interface) format - TSoundType.RMI
## - QCP (Qualcomm PureVoice) format - TSoundType.QCP
## - CD-DA (Compact Disc Digital Audio) format - TSoundType.CDDA
## - NES (NES sound) format - TSoundType.NES
## - KOZ (Sprint Music Store audio) format - TSoundType.KOZ
## - Csound (Csound music) format - TSoundType.Csound
## - Undetermined format - TSoundType.Other
## - Invalid file or byte sequence (less than 512 bytes) - TSoundType.Invalid
##
## (As Nimrod does not allow for identifier names beginning with digits, the 8SVX format
## has a TSoundType of SVX8 instead.)


type TSoundType* {.pure.} = enum
    AIFC, AIFF, AU, HCOM, VOC, WAV, SVX8, SNDT, SNDR, FLAC, MIDI, MP3, Vorbis, SMUS, CMUS,
    VOX, M4A, WMA, RA, RAStream, RMStream, DSS, DVF, AAC, AMR, BroadVoice, SILK, G117A,
    G117MU, iLBC, Musepack, Shorten, ADX, ACD, CAFF, VMD, WMMP, AST, RMI, QCP, CDDA, NES,
    KOZ, Csound, Other, Invalid


proc testSound(data : seq[int8]): TSoundType


proc int2ascii(i : seq[int8]): string = 
    ## Converts a sequence of integers into a string containing all of the characters.
    
    var s : string = ""
    for j, value in i:
        s = s & (chr(int(value)))
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


proc testSound*(file : TFile): TSoundType = 
    ## Determines the format of the sound file given.
    
    var data = newSeq[int8](512)
    var b : int = file.readBytes(data, 0, 512)
    if b < 512:
        return TSoundType.Invalid
    return testSound(data)


proc testSound*(filename : string): TSoundType = 
    ## Determines the format of the sound file with the specified filename.
    
    var file : TFile = open(filename)
    var format : TSoundType = testSound(file)
    file.close()
    return format


proc testSound*(data : seq[int8]): TSoundType = 
    ## Determines the format of the sound file from the bytes given.
    
    if len(data) < 512:
        return TSoundType.Invalid
    elif testAIFC(data):
        return TSoundType.AIFC
    elif testAIFF(data):
        return TSoundType.AIFF
    elif testAU(data):
        return TSoundType.AU
    elif testHCOM(data):
        return TSoundType.HCOM
    elif testVOC(data):
        return TSoundType.VOC
    elif testWAV(data):
        return TSoundType.WAV
    elif test8SVX(data):
        return TSoundType.SVX8
    elif testSNDT(data):
        return TSoundType.SNDT
    elif testSNDR(data):
        return TSoundType.SNDR
    elif testFLAC(data):
        return TSoundType.FLAC
    elif testMIDI(data):
        return TSoundType.MIDI
    elif testMP3(data):
        return TSoundType.MP3
    elif testVorbis(data):
        return TSoundType.Vorbis
    elif testSMUS(data):
        return TSoundType.SMUS
    elif testCMUS(data):
        return TSoundType.CMUS
    elif testVOX(data):
        return TSoundType.VOX
    elif testM4A(data):
        return TSoundType.M4A
    elif testWMA(data):
        return TSoundType.WMA
    elif testRA(data):
        return TSoundType.RA
    elif testRAStream(data):
        return TSoundType.RAStream
    elif testRMStream(data):
        return TSoundType.RMStream
    elif testDSS(data):
        return TSoundType.DSS
    elif testDVF(data):
        return TSoundType.DVF
    elif testAAC(data):
        return TSoundType.AAC
    elif testAMR(data):
        return TSoundType.AMR
    elif testBroadVoice(data):
        return TSoundType.BroadVoice
    elif testSILK(data):
        return TSoundType.SILK
    elif testG117A(data):
        return TSoundType.G117A
    elif testG117MU(data):
        return TSoundType.G117MU
    elif testiLBC(data):
        return TSoundType.iLBC
    elif testMusepack(data):
        return TSoundType.Musepack
    elif testShorten(data):
        return TSoundType.Shorten
    elif testADX(data):
        return TSoundType.ADX
    elif testACD(data):
        return TSoundType.ACD
    elif testCAFF(data):
        return TSoundType.CAFF
    elif testVMD(data):
        return TSoundType.VMD
    elif testWMMP(data):
        return TSoundType.WMMP
    elif testAST(data):
        return TSoundType.AST
    elif testRMI(data):
        return TSoundType.RMI
    elif testQCP(data):
        return TSoundType.QCP
    elif testCDDA(data):
        return TSoundType.CDDA
    elif testNES(data):
        return TSoundType.NES
    elif testKOZ(data):
        return TSoundType.KOZ
    elif testCsound(data):
        return TSoundType.Csound
    else:
        return TSoundType.Other
