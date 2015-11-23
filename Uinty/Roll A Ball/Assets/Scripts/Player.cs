using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class Player : MonoBehaviour {

	public int _force = 5;
	public Text _scoreText;
	public GameObject _winText;
	private Rigidbody rd;
	private int score = 0;
	
	// Use this for initialization
	void Start () {
        rd = GetComponent<Rigidbody>();
        _scoreText.text = score.ToString();
	}
	
	// Update is called once per frame
	void Update () {
		float h = Input.GetAxis("Horizontal");
		float v = Input.GetAxis("Vertical");
		rd.AddForce (new Vector3(h,0,v) * _force);
	}

	// 碰撞检测
	void OnCollisionEnter (Collision collision) {
		// string name = collision.collider.name;
		// print(name);
		if (collision.collider.tag == "PickUp") {
			Destroy(collision.collider.gameObject);
		}
	}

	// 触发检测
	void OnTriggerEnter (Collider collider) {
		if (collider.tag == "PickUp") {
			Destroy(collider.gameObject);
			score++;
			_scoreText.text = score.ToString();
			if (score == 8) {
				_winText.SetActive(true);
			}
		}
	}
}
