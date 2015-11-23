using UnityEngine;
using System.Collections;

public class PickUp : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	// 60 fps
	void Update () {
		transform.Rotate(new Vector3(1,1,1));
	}
}
