import java.util.Scanner;
import java.io.*;
public class CRC1 {

	public static void main(String args[]) {

		Scanner sc = new Scanner(System.in);

		//Input Data Stream
		// need not give binary values can also give like 'abcd' and is converted to binary
		System.out.print("Enter message/data bits: ");
		String message = sc.nextLine();
		System.out.print("Enter generator/divisor: ");
		String generator = sc.nextLine();
		int data[] = new int[message.length() + generator.length() - 1];
		int divisor[] = new int[generator.length()];
		for(int i=0;i<message.length();i++)
			data[i] = Integer.parseInt(message.charAt(i)+"");
		for(int i=0;i<generator.length();i++)
			divisor[i] = Integer.parseInt(generator.charAt(i)+"");

		//Calculation of CRC
		//if data[i] = 1 do operations otherwise skip
		for(int i=0;i<message.length();i++)
		{
			if(data[i]==1)
				for(int j=0;j<divisor.length;j++)
					data[i+j] ^= divisor[j];
		}

		//Display CRC
		System.out.print("The checksum code is: ");
		for(int i=0;i<message.length();i++)
			data[i] = Integer.parseInt(message.charAt(i)+"");
		for(int i=0;i<data.length;i++) 
			System.out.print(data[i]);
		System.out.println();

		/* Error detection */

		//Check for input CRC code
		System.out.print("Enter checksum code: ");
		message = sc.nextLine();
		data = new int[message.length() + generator.length() - 1];
		for(int i=0;i<message.length();i++)
			data[i] = Integer.parseInt(message.charAt(i)+"");

		//Calculation of remainder
		for(int i=0;i<message.length();i++) {
			if(data[i]==1)
				for(int j=0;j<divisor.length;j++)
					data[i+j] ^= divisor[j];
		}

		//Display validity of data
		boolean valid = true;
		for(int i=0;i<data.length;i++)
			if(data[i]==1){
				valid = false;
				break;
			}

		if(valid==true) 
			System.out.println("Data stream is valid");
		else 
			System.out.println("Data stream is invalid. CRC error occurred.");
	}

}
