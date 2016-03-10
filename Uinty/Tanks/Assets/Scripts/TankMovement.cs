using UnityEngine;
using System.Collections;

public class TankMovement : MonoBehaviour {

	public float speed = 5;
	public float angularSpeed = 10;
	public float player = 1;
	public AudioClip idleAudio;
	public AudioClip drivingAudio;

	private Rigidbody rigidbody;
	private AudioSource audio;

	// Use this for initialization
	void Start () {
		rigidbody = this.GetComponent<Rigidbody>();
		audio = this.GetComponent<AudioSource>();
	}

	void FixedUpdate() {
		float v = Input.GetAxis("VerticalPlayer"+player);
		rigidbody.velocity = transform.forward * v * speed;
		float h = Input.GetAxis("HorizontalPlayer"+player);
		rigidbody.angularVelocity = transform.up * h * angularSpeed;

		if (Mathf.Abs(v) > 0.1 || Mathf.Abs(h) > 0.1) {
			audio.clip = drivingAudio;
		} else {
			audio.clip = idleAudio;
		}
		if (audio.isPlaying == false) audio.Play();
	}
	
}
