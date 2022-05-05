class Node
{
	int size;
	int top1;
	int top2;
	int arr[];
	Node(int d)
	{
		arr=new int[d];
		size=d;
		top1=-1;
		top2=d;
	}
	void push1(int d1)
	{
		if(top1<top2-1)
		{
			top1++;
			arr[top1]=d1;
		}
		else
		{
			System.exit(1);
		}
	}
	void push2(int d2)
	{
		if(top1<top2-1)
		{
			top2--;
			arr[top2]=d2;
		}
		else
		{
			System.exit(1);
		}
	}
	int pop1()
	{
		if(top1>=0)
		{
			int temp1=arr[top1];
			top1--;
			return temp1;
		}
		else
		{
			System.exit(1);
		}
		return 0;
	}
	int pop2()
	{
		if(top2<size)
		{
			int temp2=arr[top2];
			top2++;
			return temp2;
		}
		else
		{
			System.exit(1);
		}
		return 0;
	}
	public static void main(String...args)
	{
		Node p=new Node(6);
		p.push1(5);
		p.push2(10);
		p.push2(15);
		p.push1(11);
		p.push2(7);
		p.push2(40);
		System.out.println("Popped element from stack1 is "+p.pop1());
		System.out.println("Popped element from stack2 is "+p.pop2());
	}
}