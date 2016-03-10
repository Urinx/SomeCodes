using UnityEngine;
using System.Collections;

public class Player : MonoBehaviour {

	public float smoothing = 10;
	private float restTimer = 0;
	private Vector2 targetPos = new Vector2(1,1);
	private Rigidbody2D rigidbody;
	private BoxCollider2D collider;
	private Animator animator;

	// Use this for initialization
	void Start () {
		rigidbody = GetComponent<Rigidbody2D>();
		collider = GetComponent<BoxCollider2D>();
		animator = GetComponent<Animator>();
	}
	
	// Update is called once per frame
	void Update () {
		rigidbody.MovePosition(Vector2.Lerp(transform.position, targetPos, smoothing*Time.deltaTime));

		if(GameManager.Instance.food <= 0 || GameManager.Instance.isEnd) return;

		restTimer += Time.deltaTime;
		if(restTimer<0.5) return;

		float h = Input.GetAxisRaw("Horizontal");
		float v = Input.GetAxisRaw("Vertical");
		if(h != 0) v = 0;

		if(h != 0 || v != 0){
			GameManager.Instance.ReduceFood(1);
			//碰撞检测
			collider.enabled = false;
			RaycastHit2D hit = Physics2D.Linecast(targetPos, targetPos+new Vector2(h,v));
			collider.enabled = true;
			if(hit.transform == null){
				targetPos += new Vector2(h,v);
			}
			else{
				switch(hit.collider.tag){
				case "OutWall":
					break;
				case "Wall":
					animator.SetTrigger("Attack");
					hit.collider.SendMessage("TakeDamage");
					break;
				case "Food":
					GameManager.Instance.AddFood(10);
					targetPos += new Vector2(h,v);
					Destroy(hit.transform.gameObject);
					break;
				case "Soda":
					GameManager.Instance.AddFood(20);
					targetPos += new Vector2(h,v);
					Destroy(hit.transform.gameObject);
					break;
				case "Enemy":
					targetPos += new Vector2(h,v);
					break;
				case "Exit":
					targetPos += new Vector2(h,v);
					GameManager.Instance.isEnd = true;
					GameManager.Instance.NewGame();
					break;
				}
			}
			GameManager.Instance.OnPlayerMove();
			restTimer = 0;
		}
	}

	public void TakeDamage(int lossFood){
		GameManager.Instance.ReduceFood(lossFood);
		animator.SetTrigger("Damage");
	}
}
