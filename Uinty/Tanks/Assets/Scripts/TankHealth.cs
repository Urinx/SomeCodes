using UnityEngine;
using System.Collections;

public class TankHealth : MonoBehaviour {

	public int hp = 100;
	public GameObject tankExplosionPrefab;
	public AudioClip tankExplosionAudio;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void TakeDamage() {
		hp -= Random.Range(10, 20);

		if (hp <= 0) {
			AudioSource.PlayClipAtPoint(tankExplosionAudio, transform.position);
			GameObject.Instantiate(tankExplosionPrefab, transform.position + Vector3.up, transform.rotation);
			GameObject.Destroy(this.gameObject);
		}
	}
}
