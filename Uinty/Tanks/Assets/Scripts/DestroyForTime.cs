using UnityEngine;
using System.Collections;

public class DestroyForTime : MonoBehaviour {

	public float time;

	// Use this for initialization
	void Start () {
		Destroy(this.gameObject, time);
	}
}
