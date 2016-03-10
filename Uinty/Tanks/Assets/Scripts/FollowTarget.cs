using UnityEngine;
using System.Collections;

public class FollowTarget : MonoBehaviour {

	public Transform p1;
	public Transform p2;
	private Vector3 offset;
	private Camera camera;

	// Use this for initialization
	void Start () {
		offset = transform.position - (p1.position + p2.position)/2;
		camera = this.GetComponent<Camera>();
	}
	
	// Update is called once per frame
	void Update () {
		if (p1 == null || p2 == null) return;
		transform.position = (p1.position + p2.position)/2 + offset;
		float distance = Vector3.Distance(p1.position, p2.position);
		camera.orthographicSize = distance * 0.8f;
	}
}
