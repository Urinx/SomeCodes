using UnityEngine;
using System.Collections;

public class FollowBall : MonoBehaviour {

	public Transform _playerTransform;
	private Vector3 offset;

	// Use this for initialization
	void Start () {
		offset = transform.position - _playerTransform.position;
	}
	
	// Update is called once per frame
	void Update () {
		transform.position = _playerTransform.position + offset;
	}
}
