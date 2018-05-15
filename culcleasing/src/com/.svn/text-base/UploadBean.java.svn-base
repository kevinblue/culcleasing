package com;

import java.io.*;
import java.util.Date;
import java.util.Hashtable;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;



public class UploadBean {
	public UploadBean() {
		userid = "";
		sourceFile = new String[255];
		suffix = new String[255];
		canSuffix = ".zip.jpg.jpeg.bmp.xls.doc.ppt.mpp.rar";
		objectPath = "c:/temp";
		objectFileName = new String[255];
		sis = null;
		description = new String[255];
		size = 0xa00000L;
		count = 0;
		b = new byte[4096];
		successful = true;
		fields = new Hashtable();
	}

	public void setUserid(String uid) {
		userid = uid;
	}

	public void setSuffix(String canSuffix) {
		this.canSuffix = canSuffix;
	}

	public void setObjectPath(String objectPath) {
		File file = new File(objectPath);
		if (file.exists()) {
			this.objectPath = objectPath;
		} else {
			file.mkdir();
			this.objectPath = objectPath;
		}
	}

	public void setSize(long maxSize) {
		size = maxSize;
	}

	public void setSourceFile(HttpServletRequest request) throws IOException {
		sis = request.getInputStream();
		int a = 0;
		int k = 0;
		String s = "";
		while ((a = sis.readLine(b, 0, b.length)) != -1) {
			s = new String(b, 0, a);
			System.out.println(s);
			if ((k = s.indexOf("filename=\"")) != -1) {
				s = s.substring(k + 10);
				k = s.indexOf("\"");
				s = s.substring(0, k);
				sourceFile[count] = s;
				k = s.lastIndexOf(".");
				suffix[count] = s.substring(k + 1);
				if (canTransfer(count))
					transferFile(count);
				count++;
			} else if ((k = s.indexOf("name=\"")) != -1) {
				String fieldName = s.substring(k + 6, s.length() - 3);
				sis.readLine(b, 0, b.length);
				StringBuffer fieldValue = new StringBuffer(b.length);
				while ((a = sis.readLine(b, 0, b.length)) != -1) {
					s = new String(b, 0, a - 2);
					if (b[0] == 45 && b[1] == 45 && b[2] == 45 && b[3] == 45
							&& b[4] == 45)
						break;
					fieldValue.append(s);
				}
				System.out.println(fieldName + ":" + fieldValue.toString());
				fields.put(fieldName, fieldValue.toString());
			}
			if (!successful)
				break;
		}
	}

	public String getFieldValue(String fieldName) {
		if (fields == null || fieldName == null)
			return null;
		else
			return (String) fields.get(fieldName);
	}

	public int getCount() {
		return count;
	}

	public String getObjectPath() {
		return objectPath;
	}

	public String[] getSourceFile() {
		return sourceFile;
	}

	public String[] getObjectFileName() {
		return objectFileName;
	}

	public String[] getDescription() {
		return description;
	}

	private boolean canTransfer(int i) {
		suffix[i] = suffix[i].toLowerCase();
		if (sourceFile[i].equals("") || canSuffix.indexOf("." + suffix[i]) < 0) {
			description[i] = "\u51FA\u9519\uFF1A\u8BE5\u7C7B\u578B\u6587\u4EF6\u4E0D\u5141\u8BB8\u4E0A\u4F20\uFF01\u6574\u4E2A\u4E0A\u4F20\u4E2D\u6B62. ";
			return false;
		} else {
			return true;
		}
	}

	private void transferFile(int i) {
		String x = userid + Long.toString((new Date()).getTime());
		try {
			objectFileName[i] = x + "." + suffix[i];

			FileOutputStream out = new FileOutputStream(objectPath
					+ objectFileName[i]);
			int a = 0;
			int k = 0;
			long hastransfered = 0L;
			String s = "";
			while ((a = sis.readLine(b, 0, b.length)) != -1) {
				s = new String(b, 0, a);
				if ((k = s.indexOf("Content-Type:")) != -1)
					break;
			}
			sis.readLine(b, 0, b.length);
			while ((a = sis.readLine(b, 0, b.length)) != -1) {
				s = new String(b, 0, a);
				if (b[0] == 45 && b[1] == 45 && b[2] == 45 && b[3] == 45
						&& b[4] == 45)
					break;
				out.write(b, 0, a);
				hastransfered += a;
				if (hastransfered >= size) {
					description[count] = "\u51FA\u9519\uFF1A\u6587\u4EF6\u603B\u91CF\u8FC7\u5927\uFF0C\u8BF7\u5C06\u6587\u4EF6\u538B\u7F29\u6216\u8054\u7CFB\u7BA1\u7406\u5458.";
					successful = false;
					break;
				}
			}
			out.close();
			if (!successful) {
				sis.close();
				File tmp = new File(objectPath + objectFileName[count]);
				tmp.delete();
			}
		} catch (IOException ioe) {
			description[i] = ioe.toString();
		}
	}

	public static void main(String args[]) {
		System.out.println("Test OK");
	}

	private String userid;
	private String sourceFile[];
	private String suffix[];
	private String canSuffix;
	private String objectPath;
	private String objectFileName[];
	private ServletInputStream sis;
	private String description[];
	private long size;
	private int count;
	private byte b[];
	private boolean successful;
	private Hashtable fields;

}
