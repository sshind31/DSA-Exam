class LinkedList
{
	static Node head;
	static class Node
	{
		int Data;
		Node next;
		Node(int data)
		{
			Data=data;
			next=null;
		}
	}
	Node Reverse(Node n1)
	{
		Node temp1=null;
		Node temp2=n1;
		Node temp3=null;
		while(temp2!=null)
		{
			temp3=temp2.next;
			temp2.next=temp1;
			temp2=temp3;
		}
		n1=temp1;
		return n1;
	}
	static void PrintList(Node n2)
	{
		while(n2!=null)
		{
			System.out.println(n2.Data+" ");
			n2=n2.next;
		}
	}
	
	public static void main(String...args)
	{
		LinkedList list=new LinkedList();
		list.head()=new Node(2);
		list.head.next()=new Node(4);
		list.head.next.next()=new Node(3);
		list.head.next.next.next()=new Node(4);
		list.head.next.next.next.next()=new Node(2);
		list.head.next.next.next.next.next()=new Node(5);
		list.PrintList(head);
	}
}