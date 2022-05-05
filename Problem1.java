import java.util.*;

class Problem1
{
	public static void main(String...args)
	{
		Scanner sc=new Scanner(System.in);
		int size=sc.nextInt();
		int arr[]=new int[size];
		for (int i=0;i<arr.length;i++)
		{
			arr[i]=sc.nextInt();
		}
		System.out.println();
		printarray(arr);
		InsertionSort(arr);
		System.out.println();
		printarray(arr);
	}
	static void printarray(int arr1[]){
		for (int i=0;i<arr1.length;i++)
		{
			System.out.print(arr1[i]+" ");
		}
	}
	
	static void InsertionSort(int arr2[])
	{
		int key;
		int j=0;
		for(int i=1;i<arr2.length;i++)
		{
			key=arr2[i];
			j=i-1;
			while(j>=0&&key<arr2[j])
			{
				arr2[j+1]=arr2[j];
				System.out.println();
				printarray(arr2);
				--j;
			}
			arr2[j+1]=key;
			
		}
	}
}