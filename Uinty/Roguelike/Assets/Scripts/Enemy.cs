using UnityEngine;
using System.Collections;

public class Enemy : MonoBehaviour {

	private Transform player;
	private Vector2 targetPosition;
	private Rigidbody2D rigidbody;
	private BoxCollider2D collider;
	private Animator animator;

	public float smoothing = 3;
	public int lossFood = 10;

	void Start(){
		player = GameObject.FindGameObjectWithTag("Player").transform;
		targetPosition = transform.position;
		rigidbody = GetComponent<Rigidbody2D>();
		collider = GetComponent<BoxCollider2D>();
		animator = GetComponent<Animator>();
		GameManager.Instance.enemyList.Add(this);
	}

	void Update(){
		rigidbody.MovePosition(Vector2.Lerp(transform.position, targetPosition, smoothing*Time.deltaTime));
	}

	public void Move(){
		Vector2 offset = player.position - transform.position;
		if(offset.magnitude<1.1f){
			// Attack
			animator.SetTrigger("Attack");
			player.SendMessage("TakeDamage", lossFood);
		}else{
			float x=0,y=0;
			if(Mathf.Abs(offset.y) > Mathf.Abs(offset.x)){
				if(offset.y < 0){
					y = -1;
				}else{
					y = 1;
				}
			}else{
				if(offset.y > 0){
					x = 1;
				}else{
					x = -1;
				}
			}
			//位置检测
			collider.enabled = false;
			RaycastHit2D hit = Physics2D.Linecast(targetPosition, targetPosition+new Vector2(x,y));
			collider.enabled = true;
			if(hit.transform == null){
				targetPosition += new Vector2(x,y);
			}else{
				if(hit.collider.tag == "Food" || hit.collider.tag == "Soda" || hit.collider.tag == "Enemy"){
					targetPosition += new Vector2(x, y);
				}
			}
		}
	}

}
