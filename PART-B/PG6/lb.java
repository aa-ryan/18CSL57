import java.util.Scanner;

public class lb {
	public static void main (String[] args) {
		int n, i, cap = 4, rate = 3, sent=0, recv=0, rem = 0;
		int a[] = new int[20];
		Scanner sc = new Scanner(System.in);
		System.out.print("Enter the number of packets: ");
		n = sc.nextInt();
		System.out.println("Enter the packets");
		for (i = 1; i <= n; i++) {
			a[i] = sc.nextInt();
		}
		System.out.println("Clock\tPktSize\tSent\tRecieved Remaining");
		for (i = 1; i <= n; i++) {
			if (a[i] != 0) {
				if (rem + a[i] > cap)
					recv = -1;
				else {
					recv  = a[i];
					rem += a[i];
				}
			} else {
				recv = 0;
			}
			if (rem != 0) {
				if (rem < rate) {
					sent = rem;
					rem = 0;
				} else {
					sent = rate;
					rem -= rate;
				}
			} else {
				sent = 0;
			}
		if (recv == -1)
			System.out.println(+i+"\t"+a[i]+"\tdropped\t"+sent+"\t "+rem);
		else
			System.out.println(+i+"\t"+a[i]+"\t"+recv+"\t"+sent+"\t "+rem);
		}

	}
}
