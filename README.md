About
=====

nim-sndhdr is a Nim module for determining the type of a sound file from a given file, filename, or sequence of bytes.
It can detect many common sound file formats.

Usage:
    
    testSound(file : File)
    testSound(filename : string)
    testSound(data : seq[int8])

nim-sndhdr can also be used as a command line program:

    sndhdr [filename1] [filename2] ...

List of detectable formats:

* AIFF (Audio Interchange File Format) format - `SoundType.AIFF`
* AIFC (AIFF Compressed) format - `SoundType.AIFC`
* AU (Sun audio) format - `SoundType.AU`
* HCOM (HCOM Sound Tools) format - `SoundType.HCOM`
* VOC (Creative Voice) format - `SoundType.VOC`
* 8SVX (8-Bit Sampled Voice) format - `SoundType.SVX8`
* SNDT (SndTool) format - `SoundType.SNDT`
* SNDR (Sounder) format - `SoundType.SNDR`
* FLAC (Free Lossless Audio Codec) format - `SoundType.FLAC`
* MIDI (Musical Instrument Digital Interface) format - `SoundType.MIDI`
* MP3 (MPEG-1 or MPEG-2 Audio Layer III) format - `SoundType.MP3`
* Ogg Vorbis format - `SoundType.Vorbis`
* SMUS (IFF Simple Musical Score) format - `SoundType.SMUS`
* CMUS (IFF Musical Score) format - `SoundType.CMUS`
* VOX (Dialogic ADPCM) format - `SoundType.VOX`
* M4A (MPEG-4 Part 14) format - `SoundType.M4A`
* WMA (Windows Media Audio) format - `SoundType.WMA`
* RA (RealAudio) format - `SoundType.RA`
* RA Stream (RealAudio streaming) format - `SoundType.RAStream`
* RM Stream (RealMedia streaming) format - `SoundType.RMStream`
* DSS (Digital Speech Standard) format - `SoundType.DSS`
* DVF (Sony Digital Voice) format - `SoundType.DVF`
* AAC (Advanced Audio Coding) format - `SoundType.AAC`
* AMR (Adaptive Multi-Rate) format - `SoundType.AMR`
* BroadVoice16 format - `SoundType.BroadVoice`
* SILK (Skype speech) format - `SoundType.SILK`
* G117A (G.117.0 A-law) format - `SoundType.G117A`
* G117MU (G.117.0 MU-law) format - `SoundType.G117MU`
* iLBC (Internet Low Bitrate Codec) format - `SoundType.iLBC`
* Musepack format - `SoundType.Musepack`
* Shorten format - `SoundType.Shorten`
* ADX (Dreamcast audio) format - `SoundType.ADX`
* ACD (Sony Sonic Foundry Acid Music) format - `SoundType.ACD`
* CAFF (Apple Core Audio) format - `SoundType.CAFF`
* VMD (VocalTec VoIP media) format - `SoundType.VMD`
* WMMP (Walkman MP3 container) format - `SoundType.WMMP`
* AST (Need for Speed: Underground audio) format - `SoundType.AST`
* RMI (Windows Musical Instrument Digital Interface) format - `SoundType.RMI`
* QCP (Qualcomm PureVoice) format - `SoundType.QCP`
* CD-DA (Compact Disc Digital Audio) format - `SoundType.CDDA`
* NES (NES sound) format - `SoundType.NES`
* KOZ (Sprint Music Store audio) format - `SoundType.KOZ`
* Csound (Csound music) format - `SoundType.Csound`
* Undetermined format - `SoundType.Other`
* Invalid file or byte sequence (less than 512 bytes) - `SoundType.Invalid`

(As Nim does not allow for identifier names beginning with digits, the 8SVX format
has a `SoundType` of SVX8 instead.)


License
=======

nim-sndhdr is released under the MIT open source license.
