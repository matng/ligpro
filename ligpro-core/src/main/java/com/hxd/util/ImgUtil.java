package com.hxd.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.color.ColorSpace;
import java.awt.color.ICC_ColorSpace;
import java.awt.color.ICC_Profile;
import java.awt.image.BufferedImage;
import java.awt.image.ColorConvertOp;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;

import javax.imageio.IIOException;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.swing.ImageIcon;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.sanselan.ImageReadException;
import org.apache.sanselan.Sanselan;
import org.apache.sanselan.common.byteSources.ByteSource;
import org.apache.sanselan.common.byteSources.ByteSourceFile;
import org.apache.sanselan.formats.jpeg.JpegImageParser;
import org.apache.sanselan.formats.jpeg.segments.UnknownSegment;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 图片缩放工具类
 *
 */
@SuppressWarnings("restriction")
public class ImgUtil {

	public static final int COLOR_TYPE_RGB = 1;
    public static final int COLOR_TYPE_CMYK = 2;
    public static final int COLOR_TYPE_YCCK = 3;
    
    /**压缩后宽、高最大默认值**/
    public static final float FIEXD_SIZE = 800;
    
    private static int colorType = COLOR_TYPE_RGB;
    private static boolean hasAdobeMarker = false;
    
    
    /**
     * 描述：按比例压缩图片大小和宽高
     * @param path
     * @param fileName
     * @param toFileName
     * @return
     */
    public static boolean imgScaleByEstimateSize(String path, String fileName){
    	
    	float scale = 1f;
        float quality = 0.5f;
    	String filePath = path+File.separator+fileName;
    	File fs = new File(filePath);
    	
		int width = getImgWidth(new File(filePath));
		int height = getImgHeight(new File(filePath));
		float fw = width;
		float fh = height;
		if(width > height && width > FIEXD_SIZE){
			scale = (FIEXD_SIZE/fw);
		}else if(width < height && height > FIEXD_SIZE){
			scale = (FIEXD_SIZE/fh);
		}else{
			scale = 1f;
		}
		
		long size = fs.length();
		if(size > 100 * 1024){
			int k = (int) (size / (100*1024));
			switch (k){
			case 1 : quality = 0.95f;break;
			case 2 : quality = 0.88f;break;
			case 3 : quality = 0.85f;break;
			case 4 : quality = 0.80f;break;
			case 5 : quality = 0.75f;break;
			case 6 : quality = 0.70f;break;
			case 7 : quality = 0.65f;break;
			case 8 : quality = 0.60f;break;
			case 9 : quality = 0.55f;break;
			default : quality = 0.5f;break;
			}
			imageCompress(path+File.separator, fileName, fileName, scale, quality, width, height);
		}
    	return true;
    }

	/**
	 *  按指定宽高缩放
	 * 若图片横比width小，高比height小，不变   
	 * 若图片横比width小，高比height大，高缩小到height，图片比例不变   
	 * 若图片横比width大，高比height小，横缩小到width，图片比例不变   
	 * 若图片横比width大，高比height大，图片按比例缩小，横为width或高为height   
	 * @param srcImgPath   源图路径
	 * @param toImgPath    生成的缩略图路径
	 * @param width        宽
	 * @param height       高
	 * @return
	 */
	public static boolean ImgForSize(String srcImgPath, String toImgPath,int width,int height) {
		try {
			if (StrUtil.isNull(srcImgPath) || StrUtil.isNull(toImgPath)) {
				return false;
			}
			
			//转换格式
			convertRGB(srcImgPath,toImgPath);
			// 使用源图像文件名创建ImageIcon对象。
			ImageIcon imgIcon = new ImageIcon(toImgPath);
			// 得到Image对象。
			Image img = imgIcon.getImage();

			// 构造一个预定义的图像类型的BufferedImage对象。
			BufferedImage buffImg = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			// 创建Graphics2D对象，用于在BufferedImage对象上绘图。
			Graphics2D g = buffImg.createGraphics();

			// 设置图形上下文的当前颜色为白色。
			g.setColor(Color.WHITE);
			// 用图形上下文的当前颜色填充指定的矩形区域。
			g.fillRect(0, 0, width, height);
			// 按照缩放的大小在BufferedImage对象上绘制原始图像。
			g.drawImage(img, 0, 0,width, height, null);
			// 释放图形上下文使用的系统资源。
			g.dispose();
			// 刷新此 Image 对象正在使用的所有可重构的资源.
			img.flush();
			
			// 开始生成缩略图
			FileOutputStream smallImage = new FileOutputStream(toImgPath);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(smallImage);
			JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(buffImg);

			/* 压缩质量 */
			jep.setQuality(1f, true);
			encoder.encode(buffImg, jep);

			smallImage.close();
			
			
			//调用库生成缩略图
			//Thumbnails.of(toImgPath).size(width, height).toFile(toImgPath);
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 *  按宽高大小缩放
	 * 若图片横比width小，高比height小，不变   
	 * 若图片横比width小，高比height大，高缩小到height，图片比例不变   
	 * 若图片横比width大，高比height小，横缩小到width，图片比例不变   
	 * 若图片横比width大，高比height大，图片按比例缩小，横为width或高为height   
	 * @param srcImgPath   源图路径
	 * @param toImgPath    生成的缩略图路径
	 * @return
	 */
	public static boolean ImgScaleBySize(String srcImgPath, String toImgPath) {
		try {
			if (StrUtil.isNull(srcImgPath) || StrUtil.isNull(toImgPath)) {
				return false;
			}
			
			//转换格式
			convertRGB(srcImgPath,toImgPath);
			// 使用源图像文件名创建ImageIcon对象。
			ImageIcon imgIcon = new ImageIcon(toImgPath);
			// 得到Image对象。
			Image img = imgIcon.getImage();
			int width = getImgWidth(new File(toImgPath));
			int height = getImgHeight(new File(toImgPath));
			// 构造一个预定义的图像类型的BufferedImage对象。
			BufferedImage buffImg = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			// 创建Graphics2D对象，用于在BufferedImage对象上绘图。
			Graphics2D g = buffImg.createGraphics();

			// 设置图形上下文的当前颜色为白色。
			g.setColor(Color.WHITE);
			// 用图形上下文的当前颜色填充指定的矩形区域。
			g.fillRect(0, 0, width, height);
			// 按照缩放的大小在BufferedImage对象上绘制原始图像。
			g.drawImage(img, 0, 0,width, height, null);
			// 释放图形上下文使用的系统资源。
			g.dispose();
			// 刷新此 Image 对象正在使用的所有可重构的资源.
			img.flush();
			
			// 开始生成缩略图
			FileOutputStream smallImage = new FileOutputStream(toImgPath);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(smallImage);
			JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(buffImg);

			/* 压缩质量 */
			jep.setQuality(1f, true);
			encoder.encode(buffImg, jep);

			smallImage.close();
			
			
			//调用库生成缩略图
			//Thumbnails.of(toImgPath).size(width, height).toFile(toImgPath);
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/**
	 * 按指定大小缩放图片
	 * @param srcImgPath
	 * @param toImgPath
	 * @param width
	 * @param height
	 * @return
	 */
	public static boolean ImgForFixedSize(String srcImgPath, String toImgPath,
			int width, int height) {
		try {
			if (StrUtil.isNull(srcImgPath) || StrUtil.isNull(toImgPath)) {
				return false;
			}

			// 转换格式
			convertRGB(srcImgPath, toImgPath);

			// 调用库生成缩略图
			Thumbnails.of(toImgPath).size(width, height).keepAspectRatio(true).toFile(toImgPath);

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
	/**
	 * 按照比例进行缩放
	 * 
	 * @param srcImgPath     源图路径
	 * @param toImgPath      生成的缩略图路径
	 * @param f              缩放系数
	 * @return
	 */
	public static boolean ImgForScale(String srcImgPath, String toImgPath,float f) {
		try {
			if (StrUtil.isNull(srcImgPath) || StrUtil.isNull(toImgPath)) {
				return false;
			}
			
			//转换格式
			convertRGB(srcImgPath,toImgPath);
			
			//调用库生成缩略图
			Thumbnails.of(toImgPath).scale(f).toFile(toImgPath);
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
	/**
	 * 按宽高缩放后，并按图片格式转换，可以转换png,jpg,gif等格式
	 * @param srcImgPath
	 * @param toImgPath
	 * @param format
	 * @return
	 */
	public static boolean ImgForSizeWithFormat(String srcImgPath, String toImgPath, int width,int height,String format) {
		try {
			
			if (StrUtil.isNull(srcImgPath) || StrUtil.isNull(toImgPath)) {
				return false;
			}
			
			//转换格式
			convertRGB(srcImgPath,toImgPath);
			
			//调用库生成缩略图
			Thumbnails.of(toImgPath).size(width, height).outputFormat(format).toFile(toImgPath);
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public static void convertRGB(String srcImgPath, String toImgPath) {
		try {
			//cmyk 转换成 rgb 格式
			BufferedImage buffImg = readImage(srcImgPath);
			FileOutputStream toImage = new FileOutputStream(toImgPath);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(toImage);
			JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(buffImg);
			//压缩质量 
			jep.setQuality(0.7f, true);
			encoder.encode(buffImg, jep);
			toImage.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	 public static BufferedImage readImage(String file) throws IOException, ImageReadException {
	        colorType = COLOR_TYPE_RGB;
	        hasAdobeMarker = false;

	        ImageInputStream stream = ImageIO.createImageInputStream(new File(file));
	        Iterator<ImageReader> iter = ImageIO.getImageReaders(stream);
	        while (iter.hasNext()) {
	            ImageReader reader = iter.next();
	            reader.setInput(stream);

	            BufferedImage image;
	            ICC_Profile profile = null;
	            try {
	                image = reader.read(0);
	            } catch (IIOException e) {
	                colorType = COLOR_TYPE_CMYK;
	                checkAdobeMarker(file);
	                profile = Sanselan.getICCProfile(new File(file));
	                WritableRaster raster = (WritableRaster) reader.readRaster(0, null);
	                if (colorType == COLOR_TYPE_YCCK)
	                    convertYcckToCmyk(raster);
	                if (hasAdobeMarker)
	                    convertInvertedColors(raster);
	                image = convertCmykToRgb(raster, profile);
	            }
	            
	            return image;
	        }

	        return null;
	    }

	    public static void checkAdobeMarker(String file) throws IOException, ImageReadException {
	        JpegImageParser parser = new JpegImageParser();
	        ByteSource byteSource = new ByteSourceFile(new File(file));
	        @SuppressWarnings("rawtypes")
	        ArrayList segments = parser.readSegments(byteSource, new int[] { 0xffee }, true);
	        if (segments != null && segments.size() >= 1) {
	            UnknownSegment app14Segment = (UnknownSegment) segments.get(0);
	            byte[] data = app14Segment.bytes;
	            if (data.length >= 12 && data[0] == 'A' && data[1] == 'd' && data[2] == 'o' && data[3] == 'b' && data[4] == 'e')
	            {
	                hasAdobeMarker = true;
	                int transform = app14Segment.bytes[11] & 0xff;
	                if (transform == 2)
	                    colorType = COLOR_TYPE_YCCK;
	            }
	        }
	    }

	    public static void convertYcckToCmyk(WritableRaster raster) {
	        int height = raster.getHeight();
	        int width = raster.getWidth();
	        int stride = width * 4;
	        int[] pixelRow = new int[stride];
	        for (int h = 0; h < height; h++) {
	            raster.getPixels(0, h, width, 1, pixelRow);

	            for (int x = 0; x < stride; x += 4) {
	                int y = pixelRow[x];
	                int cb = pixelRow[x + 1];
	                int cr = pixelRow[x + 2];

	                int c = (int) (y + 1.402 * cr - 178.956);
	                int m = (int) (y - 0.34414 * cb - 0.71414 * cr + 135.95984);
	                y = (int) (y + 1.772 * cb - 226.316);

	                if (c < 0) c = 0; else if (c > 255) c = 255;
	                if (m < 0) m = 0; else if (m > 255) m = 255;
	                if (y < 0) y = 0; else if (y > 255) y = 255;

	                pixelRow[x] = 255 - c;
	                pixelRow[x + 1] = 255 - m;
	                pixelRow[x + 2] = 255 - y;
	            }

	            raster.setPixels(0, h, width, 1, pixelRow);
	        }
	    }

	    public static void convertInvertedColors(WritableRaster raster) {
	        int height = raster.getHeight();
	        int width = raster.getWidth();
	        int stride = width * 4;
	        int[] pixelRow = new int[stride];
	        for (int h = 0; h < height; h++) {
	            raster.getPixels(0, h, width, 1, pixelRow);
	            for (int x = 0; x < stride; x++)
	                pixelRow[x] = 255 - pixelRow[x];
	            raster.setPixels(0, h, width, 1, pixelRow);
	        }
	    }

	    public static BufferedImage convertCmykToRgb(Raster cmykRaster, ICC_Profile cmykProfile) throws IOException {
	        if (cmykProfile == null)
	            cmykProfile = ICC_Profile.getInstance(ImgUtil.class.getResourceAsStream("/ISOcoated_v2_300_eci.icc"));
	        ICC_ColorSpace cmykCS = new ICC_ColorSpace(cmykProfile);
	        BufferedImage rgbImage = new BufferedImage(cmykRaster.getWidth(), cmykRaster.getHeight(), BufferedImage.TYPE_INT_RGB);
	        WritableRaster rgbRaster = rgbImage.getRaster();
	        ColorSpace rgbCS = rgbImage.getColorModel().getColorSpace();
	        ColorConvertOp cmykToRgb = new ColorConvertOp(cmykCS, rgbCS, null);
	        cmykToRgb.filter(cmykRaster, rgbRaster);
	        return rgbImage;
	    }
	    
	    /**
	     * 描述：按压缩比和图片质量压缩图片
	     * 
	     * @param path
	     *            需要压缩的图片路径
	     * @param fileName
	     *            要压缩的图片名称
	     * @param toFileName
	     *            压缩后的图片名称
	     * @param scale
	     *            压缩比例 不能大于1,默认0.5
	     * @param quality
	     *            压缩品质介于0.1~1.0之间
	     * @param width
	     *            压缩后的图片的宽度
	     * @param height
	     *            压缩后的图片的高度 返回值：void
	     */
		public static void imageCompress(String path, String fileName,
	            String toFileName, float scale, float quality, int width, int height) {
	        try { // 原图路径 原图名称 目标路径 压缩比率0.5 0.75 原图宽度 原图高度
	            long start = System.currentTimeMillis();
	            Image image = javax.imageio.ImageIO.read(new File(path + fileName));
	            int imageWidth = image.getWidth(null);
	            int imageHeight = image.getHeight(null);
	            //if (scale > 0.5)
	               // scale = 0.5f;// 默认压缩比为0.5，压缩比越大，对内存要去越高，可能导致内存溢出
	            // 按比例计算出来的压缩比
	            float realscale = getRatio(imageWidth, imageHeight, width, height);
	            float finalScale = Math.min(scale, realscale);// 取压缩比最小的进行压缩
	            imageWidth = (int) (finalScale * imageWidth);
	            imageHeight = (int) (finalScale * imageHeight);

	            image = image.getScaledInstance(imageWidth, imageHeight,
	                    Image.SCALE_AREA_AVERAGING);
	            // Make a BufferedImage from the Image.
	            BufferedImage mBufferedImage = new BufferedImage(imageWidth,
	                    imageHeight, BufferedImage.TYPE_INT_RGB);
	            Graphics2D g2 = mBufferedImage.createGraphics();

	            g2.drawImage(image, 0, 0, imageWidth, imageHeight, Color.white,
	                    null);
	            g2.dispose();

	            float[] kernelData2 = { -0.125f, -0.125f, -0.125f, -0.125f, 2,
	                    -0.125f, -0.125f, -0.125f, -0.125f };
	            Kernel kernel = new Kernel(3, 3, kernelData2);
	            ConvolveOp cOp = new ConvolveOp(kernel, ConvolveOp.EDGE_NO_OP, null);
	            mBufferedImage = cOp.filter(mBufferedImage, null);

	            FileOutputStream out = new FileOutputStream(path + toFileName);
	            System.out.println(path + toFileName);
	            // JPEGEncodeParam param =
	            // encoder.getDefaultJPEGEncodeParam(bufferedImage);
	            // param.setQuality(0.9f, true);
	            // encoder.setJPEGEncodeParam(param);
	            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
	            JPEGEncodeParam param = encoder
	                    .getDefaultJPEGEncodeParam(mBufferedImage);
	            param.setQuality(quality, true);// 默认0.75
	            encoder.setJPEGEncodeParam(param);
	            encoder.encode(mBufferedImage);
	            out.close();
	            long end = System.currentTimeMillis();
	            System.out.println("图片：" + fileName + "，压缩时间：" + (end - start)
	                    + "ms");
	        } catch (FileNotFoundException fnf) {
	        } catch (IOException ioe) {
	            ioe.printStackTrace();
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        } finally {

	        }
	    }

	    private static float getRatio(int width, int height, int maxWidth,
	            int maxHeight) {// 获得压缩比率的方法
	        float Ratio = 1.0f;
	        float widthRatio;
	        float heightRatio;
	        widthRatio = (float) maxWidth / width;
	        heightRatio = (float) maxHeight / height;
	        if (widthRatio < 1.0 || heightRatio < 1.0) {
	            Ratio = widthRatio <= heightRatio ? widthRatio : heightRatio;
	        }
	        return Ratio;
	    }
	    
	    /**
	     * 获取图片宽度
	     * @param file  图片文件
	     * @return 宽度
	     */
	    public static int getImgWidth(File file) {
	        InputStream is = null;
	        BufferedImage src = null;
	        int ret = -1;
	        try {
	            is = new FileInputStream(file);
	            src = javax.imageio.ImageIO.read(is);
	            ret = src.getWidth(null); // 得到源图宽
	            is.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return ret;
	    }
	      
	      
	    /**
	     * 获取图片高度
	     * @param file  图片文件
	     * @return 高度
	     */
	    public static int getImgHeight(File file) {
	        InputStream is = null;
	        BufferedImage src = null;
	        int ret = -1;
	        try {
	            is = new FileInputStream(file);
	            src = javax.imageio.ImageIO.read(is);
	            ret = src.getHeight(null); // 得到源图高
	            is.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return ret;
	    }
	    
	//测试方法
	public static void main(String[] args) {
		try {
			String imgName = "02.jpg";
			String src = "d:/tmp/"+imgName;
			String to = "d:/tmp/small_1_"+imgName;
			String to2 = "d:/tmp/small_2_"+imgName;
			//String to3 = "d:/tmp/small_3_"+imgName;
			ImgForSize(src,to,290,220);
			ImgForScale(src,to2, 0.25f);
			//ImgForSizeWithFormat(src,to3,200,300,"png");
					
			
			System.out.println("Image scal done!");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
