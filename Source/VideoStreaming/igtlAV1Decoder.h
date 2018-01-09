/*=========================================================================
 
 Program:   VPXEncoder
 Language:  C++
 
 Copyright (c) Insight Software Consortium. All rights reserved.
 
 This software is distributed WITHOUT ANY WARRANTY; without even
 the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.  See the above copyright notices for more information.
 
 =========================================================================*/

#ifndef __igtlAV1Decoder_h
#define __igtlAV1Decoder_h

#include <time.h>
#if defined(_WIN32) /*&& defined(_DEBUG)*/
  #include <windows.h>
  #include <stdio.h>
  #include <stdarg.h>
  #include <sys/types.h>
#else
  #include <sys/time.h>
#endif

#include <vector>
#include <limits.h>
#include <string.h>
#include "igtl_types.h"
#include "igtlVideoMessage.h"
#include "igtlCodecCommonClasses.h"

#include "av1/decoder/decoder.h"
#include "av1/av1_iface_common.h"

//#include "vpx/vpx_decoder.h"
//#include "vpx_config.h"
//#include "vpx/vp8dx.h"
//#include "vpx/vpx_codec.h"
//#include "vpx/vpx_image.h"
//#include "vpx/vpx_integer.h"

#ifdef __cplusplus
extern "C" {
#endif
  typedef struct Av1InterfaceDecoder {
    //av1 *(*const codec_interface)();
  } Av1InterfaceDecoder;
  
#ifdef __cplusplus
} /* extern "C" */
#endif

#define NO_DELAY_DECODING
class igtlAV1Decoder:public GenericDecoder
{
public: 
  igtlAV1Decoder();
  ~igtlAV1Decoder();
  
  virtual int DecodeBitStreamIntoFrame(unsigned char* bitStream,igtl_uint8* outputFrame, igtl_uint32 iDimensions[2], igtl_uint64 &iStreamSize);
  
  virtual int DecodeVideoMSGIntoSingleFrame(igtl::VideoMessage* videoMessage, SourcePicture* pDecodedPic);
  
private:
  virtual void ComposeByteSteam(igtl_uint8** inputData, int dimension[2], int iStride[2], igtl_uint8 *outputFrame);
  
  const AV1Decoder* decoder;
  
  //int vpx_img_plane_width(const vpx_image_t *img, int plane);
  //
  //int vpx_img_plane_height(const vpx_image_t *img, int plane);
  //
  //vpx_codec_ctx_t codec;
  //
  //vpx_image_t* outputImage;
  //
  //vpx_codec_iter_t iter;
  
};

#endif